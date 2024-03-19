import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/ResumeGeneralPage.dart';
import 'package:uuid/uuid.dart';

import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import '../services/authenticationService.dart';

class LessonViewModel extends ChangeNotifier {
  final LessonRepository _lessonRepository;
  final authenticationService = AuthenticationService();


  LessonViewModel(this._lessonRepository) {
    _loadApiKey();
    _loadUserUID();
    _lessonRepository.initialize();
  }

  List<Note> _lessons = [];

  late String _uidUser ;

  List<Note> get lessons => _lessons;
  String _apiKey = "";


  Future<void> deleteAllNotes() async {
    await _lessonRepository.initialize();
    await _lessonRepository.deleteAllNotes();
  }

  Future<void> deleteNote(Note lesson) async {
    await _lessonRepository.initialize();
    await _lessonRepository.deleteNote(lesson);
  }

  Future<void> _loadApiKey() async {
    await dotenv.load(fileName: '.env');
    _apiKey = dotenv.env['API_KEY']!;
  }
 void  _loadUserUID()  {
   _uidUser = authenticationService.getCurrentUIDUser();
  }

  Future<List<Note>> getAllNotes() async {
    await _lessonRepository.initialize();
    _lessons = await _lessonRepository.getAllNotes();
    return _lessons;
    notifyListeners();
  }

  Future<List<Note>> geminiAllNotes() async {
    final allNotes = await getAllNotes();

    // Map para armazenar as notas agrupadas por categoria
    Map<String, List<Note>> groupedNotes = {};

    for (var lesson in allNotes) {
      if (groupedNotes.containsKey(lesson.category)) {
        groupedNotes[lesson.category]!.add(lesson);
      } else {
        groupedNotes[lesson.category] = [lesson];
      }
    }

    List<Note> listNotesCategories = [];

    // Lista para armazenar todos os futuros
    List<Future<Note>> futures = [];

    // Processa as notas agrupadas
    groupedNotes.forEach((category, lessons) {
      // Adiciona um futuro para cada nota ao invés da nota diretamente
      futures.add(summarizeNotesByCategory(lessons, category));
    });

    // Aguarda a conclusão de todos os futuros
    List<Note> summarizedNotes = await Future.wait(futures);

    // Adiciona as notas resumidas à lista final
    listNotesCategories.addAll(summarizedNotes);

    return listNotesCategories;
  }

  Future<Note> summarizeNotesByCategory(List<Note> listNote,
      String category) async {
    // a Note retornada só deve ser atualizada só se for da mesma categoria e
    // quando uma nova nota é salva no banco de dados

    // Esse método deve fazer o resumo das lista de notas
    // de mesma categoria (algo acumulativo)
    // e devolver uma nova nota resumida do geral disso tudo

    String allMessages = "";

    listNote.forEach((element) {
      if (element.category == category) {
        allMessages += "${element.message}. \n \n";
      }
    });
    final model = GenerativeModel(model: 'gemini-pro', apiKey: _apiKey);

    final contentTitle = [
      Content.text(" "
          "Faça um titulo de no máximo 10 caracteres baseado no texto seguir:"
          " ${allMessages}")
    ];
    final responseTitle = await model.generateContent(contentTitle);

    final contentMessage = [
      Content.text(" "
          "Faça um Resumo desse aglomerado de textos, mas busque "
          "informações complementares, ressalte os assuntos mais importantes e "
          "corrija o que pode estar errado na anotação:"
          " ${allMessages}")
    ];
    final responseMessage = await model.generateContent(contentMessage);

    // dar um jeito de pegar o id do user e deixar aberto no viewModel
    //gerar um UUID tbm para as notas e liçoes do gemini

    final uuid = Uuid();
    String id = uuid.v4();

    final geminiNote = Note(
      id: id,
      idUser: _uidUser,
      category: category,
      title: responseTitle.text!,
      message: responseMessage.text!,);

    print(geminiNote.message);

    return geminiNote;
  }

  // Future<void> initialize() async {
  //   await _lessonRepository.initialize();
  // }

  Future<void> createNewNote(Note lesson, BuildContext context) async {
    await _lessonRepository.initialize();
    await _lessonRepository.saveNote(lesson);
    await getAllNotes();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnnotationPage(),
      ),
    );
  }
}
