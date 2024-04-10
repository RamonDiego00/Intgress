import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/ResumeGeneralPage.dart';
import 'package:uuid/uuid.dart';

import '../core/repository/LessonRepository.dart';
import '../core/repository/LessonRepository.dart';
import '../models/Lesson.dart';
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

  List<Lesson> _lessons = [];

  late String _uuser_id;

  List<Lesson> get lessons => _lessons;
  String _apiKey = "";

  Future<void> _loadApiKey() async {
    await dotenv.load(fileName: '.env');
    _apiKey = dotenv.env['API_KEY']!;
  }

  void _loadUserUID() {
    _uuser_id = authenticationService.getCurrentUuser_id();
  }

  Future<void> createNewLesson(BuildContext context, Note note) async {
    //Vamos criar lições aqui e subir para a lista global as liçoes

    final model = GenerativeModel(model: 'gemini-pro', apiKey: _apiKey);

    final contentLesson = [
      Content.text(" "
          "Uma questão precisa ter cada item a seguir:   Enunciado:  Pergunta: alternativa 1: alternativa 2: alternativa 3:  "
          "correta .Eu "
          "quero que voce coloque um @ no final do de cada item. Enunciado:  Pergunta: alternativa 1: alternativa 2: alternativa 3:  "
          "correta : . "
          "Lembre de seguir "
          "essas instruções e faça a pergunta,enunciado, e as 3 alternaivas de resposta referentes ao texto abaixo."
          ""
          " ${note.message}")
    ];
    final responseLesson = await model.generateContent(contentLesson);

    print(responseLesson.text!);

    // aqui vamos capturar cada texto baseado na string enorme acima

    final regexEnunciado = RegExp(r"\*\*Enunciado:\*\* (.*?) @", dotAll: true);
    final regexPergunta = RegExp(r"\*\*Pergunta:\*\* \s*(.*?) @", dotAll: true);
    final regexAlternativa1 = RegExp(r"\*\*Alternativa 1:\*\* \s*(.*?) @", dotAll: true);
    final regexAlternativa2 = RegExp(r"\*\*Alternativa 2:\*\* \t*(.*?) @", dotAll: true);
    final regexAlternativa3 = RegExp(r"\*\*Alternativa 3:\*\* \s*(.*?) @", dotAll: true);
    final regexCorrreta = RegExp(r"\*\*Correta:\*\* (.*?) @", dotAll: true);


    final statement = regexEnunciado.firstMatch(responseLesson.text.toString())?.group(1);
    final question = regexPergunta.firstMatch(responseLesson.text.toString())?.group(1);
    final alternative1 = regexAlternativa1.firstMatch(responseLesson.text.toString())?.group(1);
    final alternative2 = regexAlternativa2.firstMatch(responseLesson.text.toString())?.group(1);
    final alternative3 = regexAlternativa3.firstMatch(responseLesson.text.toString())?.group(1);
    final correct = regexCorrreta.firstMatch(responseLesson.text.toString())?.group(1);







    print("Enunciado: $statement");
    print("Pergunta: $question");
    print("Alternativa 1: $alternative1");
    print("Alternativa 2: $alternative2");
    print("Alternativa 3: $alternative3");
    print("Correta: $correct");



    // print('Correta: $correta');

    final uuid = Uuid();
    String id = uuid.v4();

    print("id: $id");
    print("noteId: ${note.id}");
    print("Enunciado: ${note.category}");

    final geminiLesson = Lesson(
        id: id,
        note_id: note.id,
        title_note: note.title,
        category_note: note.category,
        statement: statement.toString(),
        question: question.toString(),
        alternative1: alternative1.toString(),
        alternative2: alternative2.toString(),
        alternative3: alternative3.toString(),
        correct: correct.toString());
//
    print(geminiLesson.statement);

    _lessons.add(geminiLesson);
// salvar nos banco de dados
    _lessonRepository.saveLesson(geminiLesson);

  }

  Future<List<Lesson>> getAllLessons() async {
    await _lessonRepository.initialize();
    _lessons = await _lessonRepository.getAllLessons();
    return _lessons;
    notifyListeners();
  }

  Future<void> deleteAllLessons() async {
    await _lessonRepository.initialize();
    await _lessonRepository.deleteAllLessons();
  }

  Future<void> deleteLesson(Lesson lesson) async {
    await _lessonRepository.initialize();
    await _lessonRepository.deleteLesson(lesson);
  }

  Future<List<Lesson>> geminiAllLessons() async {
    final allLessons = await getAllLessons();

    // Map para armazenar as notas agrupadas por categoria
    Map<String, List<Lesson>> groupedLessons = {};

    // for (var lesson in allLessons) {
    //   if (groupedLessons.containsKey(lesson.category)) {
    //     groupedLessons[lesson.category]!.add(lesson);
    //   } else {
    //     groupedLessons[lesson.category] = [lesson];
    //   }
    // }

    List<Lesson> listLessonsCategories = [];

    // Lista para armazenar todos os futuros
    List<Future<Lesson>> futures = [];

    // Processa as notas agrupadas
    groupedLessons.forEach((category, lessons) {
      // Adiciona um futuro para cada nota ao invés da nota diretamente
      // futures.add(summarizeLessonsByCategory(lessons, category));
    });

    // Aguarda a conclusão de todos os futuros
    List<Lesson> summarizedLessons = await Future.wait(futures);

    // Adiciona as notas resumidas à lista final
    listLessonsCategories.addAll(summarizedLessons);

    return listLessonsCategories;
  }

  Future<Lesson?> summarizeLessonsByCategory(
      List<Lesson> listLesson, String category) async {
    // a Lesson retornada só deve ser atualizada só se for da mesma categoria e
    // quando uma nova nota é salva no banco de dados

    // Esse método deve fazer o resumo das lista de notas
    // de mesma categoria (algo acumulativo)
    // e devolver uma nova nota resumida do geral disso tudo

    String allMessages = "";

    // listLesson.forEach((element) {
    //   if (element.category == category) {
    //     allMessages += "${element.message}. \n \n";
    //   }
    // });
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

    // final geminiLesson = Lesson(
    //   id: id,
    //   user_id: _uuser_id,
    //   category: category,
    //   title: responseTitle.text!,
    //   message: responseMessage.text!,);
    //
    // print(geminiLesson.message);

    return null;
  }

// Future<void> initialize() async {
//   await _lessonRepository.initialize();
// }
}
