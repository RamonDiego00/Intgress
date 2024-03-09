

import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final _databaseName = "my_database.db";
  static final _databaseVersion = 1;

  AppDatabase._privateConstructor();

  static final AppDatabase instance = AppDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final path = await getDatabasesPath();
    return await openDatabase(
      '$path/$_databaseName',
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            message TEXT NOT NULL
          )
        ''');
      },
    );
  }
}
