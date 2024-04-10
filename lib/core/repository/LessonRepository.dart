import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/Lesson.dart';
import '../../models/Lesson.dart';
import '../database/DB.dart';
import '../database/database.dart'; // Importe sua classe de banco de dados

class LessonRepository extends ChangeNotifier {
  late Database db;
  late FirebaseFirestore cloud;

  LessonRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
    cloud = FirebaseFirestore.instance;
  }

  Future<void> initialize() async {
    db = await DB.instance.database;
    cloud = FirebaseFirestore.instance;
  }

  Future<void> saveLesson(Lesson lesson) async {
    try {
      await db.insert('lessons', lesson.toMap());
      notifyListeners();

    } catch (e) {
      // Trate qualquer erro de inserção aqui
      print('Erro ao salvar lição: $e');
    }

    try{
      // passar o id do documento que já existe ele vai atualizar no firestore
      cloud.collection("Lessons").doc(lesson.id!).set(lesson.toMap()) ;

    } catch(e){
      print("Erro ao salvar em nuvem a lição: $e");
    }

  }

  Future<void> deleteLesson(Lesson lesson) async {
    try {
      await db.delete('lessons', where: 'id = ?', whereArgs: [lesson.id]);
      await db.delete('lesson_lesson_relation', where: 'lesson_id = ?', whereArgs: [lesson.id]);
    } catch (e) {
      print('Erro ao excluir nota: $e');
    }
  }
  Future<void> deleteAllLessons() async {
    try {
      await db.delete('lessons');
      notifyListeners();
    } catch (e) {
      print('Erro ao excluir todas as notas: $e');
    }
  }

  Future<void> updateLesson(Lesson lesson) async {
    try {
      await db.update('lessons', lesson.toMap(), where: 'id = ?', whereArgs: [lesson.id]);
    } catch (e) {
      print('Erro ao atualizar nota: $e');
    }
  }


  Future<List<Lesson>> getAllLessons() async {
    try {
      final List<Map<String, dynamic>> lessonMaps = await db.query('lessons');
      final List<Lesson> lessons = [];

      for (var lessonMap in lessonMaps) {
        // Extraia todos os dados da lição
        final String lessonId = lessonMap['id'];
        final String noteId = lessonMap['note_id'];
        final String titleNote = lessonMap['title_note'];
        final String categoryNote = lessonMap['category_note'];
        final String statement = lessonMap['statement'];
        final String question = lessonMap['question'];
        final String alternative1 = lessonMap['alternative1'];
        final String alternative2 = lessonMap['alternative2'];
        final String alternative3 = lessonMap['alternative3'];
        final String correct = lessonMap['correct'];

        // Crie um novo objeto Lesson
        final lesson = Lesson(
          id: lessonId,
          note_id: noteId,
          title_note: titleNote,
          category_note: categoryNote,
          statement: statement,
          question: question,
          alternative1: alternative1,
          alternative2: alternative2,
          alternative3: alternative3,
          correct: correct,
        );

        lessons.add(lesson);
      }

      return lessons;
    } catch (e) {
      print('Erro ao recuperar lições: $e');
      return [];
    }
  }





}
