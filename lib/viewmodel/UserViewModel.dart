import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intgress/core/repository/UserRepository.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/ResumeGeneralPage.dart';

import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository) {
    _loadApiKey();
    _userRepository.initialize();
  }

  List<Note> _notes = [];

  List<Note> get notes => _notes;
  String _apiKey = "";


  Future<void> deleteAllNotes() async {
    // await _noteRepository.initialize();
    // await _noteRepository.deleteAllNotes();
  }

  Future<void> deleteNote(Note note) async {
    // await _noteRepository.initialize();
    // await _noteRepository.deleteNote(note);
  }

  Future<void> _loadApiKey() async {
    await dotenv.load(fileName: '.env');
    _apiKey = dotenv.env['API_KEY']!;
  }

  Future<List<Note>> getAllNotes() async {
    // await _noteRepository.initialize();
    // _notes = await _noteRepository.getAllNotes();
    return _notes;
    notifyListeners();
  }

  Future<List<Note>> geminiAllNotes() async {
    final allNotes = await getAllNotes();

    // Map para armazenar as notas agrupadas por categoria
    Map<String, List<Note>> groupedNotes = {};

    for (var note in allNotes) {
      if (groupedNotes.containsKey(note.category)) {
        groupedNotes[note.category]!.add(note);
      } else {
        groupedNotes[note.category] = [note];
      }
    }

    List<Note> listNotesCategories = [];

    // Lista para armazenar todos os futuros
    List<Future<Note>> futures = [];

    // Processa as notas agrupadas
    groupedNotes.forEach((category, notes) {
      // Adiciona um futuro para cada nota ao invés da nota diretamente
      futures.add(summarizeNotesByCategory(notes, category));
    });

    // Aguarda a conclusão de todos os futuros
    List<Note> summarizedNotes = await Future.wait(futures);

    // Adiciona as notas resumidas à lista final
    listNotesCategories.addAll(summarizedNotes);

    return listNotesCategories;
  }

  Future<Note> summarizeNotesByCategory(
      List<Note> listNote, String category) async {
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

    final geminiNote = Note(

        category: category,
        title: responseTitle.text!,
        message: responseMessage.text!,
        lessons: []);

    print(geminiNote.message);

    return geminiNote;
  }

  // Future<void> initialize() async {
  //   await _noteRepository.initialize();
  // }

  Future<void> createNewNote(Note note, BuildContext context) async {
    // await _noteRepository.initialize();
    // await _noteRepository.saveNote(note);
    await getAllNotes();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnnotationPage(),
      ),
    );
  }
}
