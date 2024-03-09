import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/Lesson.dart';
import '../../models/Note.dart';
import '../database/DB.dart';
import '../database/database.dart'; // Importe sua classe de banco de dados

class UserRepository extends ChangeNotifier {
  late Database db;

  UserRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  Future<void> initialize() async {
    db = await DB.instance.database;
  }

  Future<void> saveNote(Note note) async {
    try {
      await db.insert('notes', note.toMap());
      notifyListeners();
    } catch (e) {
      // Trate qualquer erro de inserção aqui
      print('Erro ao salvar nota: $e');
    }
  }

  Future<void> deleteNote(Note note) async {
    try {
      await db.delete('notes', where: 'id = ?', whereArgs: [note.id]);
      await db.delete('note_lesson_relation', where: 'note_id = ?', whereArgs: [note.id]);
    } catch (e) {
      print('Erro ao excluir nota: $e');
    }
  }
  Future<void> deleteAllNotes() async {
    try {
      await db.delete('notes');
      notifyListeners();
    } catch (e) {
      print('Erro ao excluir todas as notas: $e');
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    } catch (e) {
      print('Erro ao atualizar nota: $e');
    }
  }


  Future<List<Note>> getAllNotes() async {
    try {
      final List<Map<String, dynamic>> noteMaps = await db.query('notes');
      final List<Note> notes = [];

      for (var noteMap in noteMaps) {
        final int noteId = noteMap['id'];

        // Consultar as lições associadas a esta nota na tabela de relação
        final List<Map<String, dynamic>> relationMaps = await db.query(
          'note_lesson_relation',
          where: 'note_id = ?',
          whereArgs: [noteId],
        );

        // Obter os IDs das lições associadas
        final List<int> lessonIds = relationMaps.map((map) => map['lesson_id'] as int).toList();

        // Consultar as lições correspondentes aos IDs obtidos
        final List<Lesson> lessons = [];
        for (var lessonId in lessonIds) {
          final Map<String, dynamic> lessonMap = (await db.query(
            'lessons',
            where: 'id = ?',
            whereArgs: [lessonId],
          )).first;
          lessons.add(Lesson.fromMap(lessonMap));
        }

        final Note note = Note(
          id: noteId,
          title: noteMap['title'],
          message: noteMap['message'],
          category: noteMap['category'],
          lessons: lessons,
        );

        notes.add(note);
      }

      return notes;
    } catch (e) {
      print('Erro ao recuperar notas: $e');
      return [];
    }
  }




}
