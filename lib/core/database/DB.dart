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
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_users);
    await db.execute(_notes);
    await db.execute(_lessons);
  }

  String get _notes => '''
    CREATE TABLE notes (
      user_id TEXT,
      id TEXT,
      title TEXT,
      message TEXT,
      category TEXT
    )
  ''';

  String get _users => '''
    CREATE TABLE users (
      id TEXT,
      name TEXT,
      email TEXT,
      password TEXT
    )
  ''';

// vai virar um JSON
  String get _lessons => '''
    CREATE TABLE lessons (
      id TEXT,
      statement TEXT,
      question TEXT,
      alternative1 TEXT,
      alternative2 TEXT,
      alternative3 TEXT,
      correct TEXT,
      note_id TEXT
    )
  ''';
}
