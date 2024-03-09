import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    await _initDatabase();
    return _database!;
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'intgrees.db'),
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_notes);
    await db.execute(_lessons);
    await db.execute(_noteLessonRelation);
  }

  String get _notes => '''
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      message TEXT,
      category TEXT,
      lessons TEXT
    )
  ''';

  String get _noteLessonRelation => '''
  CREATE TABLE note_lesson_relation (
    note_id INTEGER,
    lesson_id INTEGER,
    FOREIGN KEY (note_id) REFERENCES notes(id),
    FOREIGN KEY (lesson_id) REFERENCES lessons(id)
  )
''';

// vai virar um JSON
  String get _lessons => '''
    CREATE TABLE lessons (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      statement TEXT,
      question TEXT,
      alternative1 TEXT,
      alternative2 TEXT,
      alternative3 TEXT,
      correct TEXT,
      note_id INTEGER,
      FOREIGN KEY (note_id) REFERENCES notes(id)
    )
  ''';
}
