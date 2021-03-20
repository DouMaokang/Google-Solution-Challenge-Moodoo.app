import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(
        path,
        version: 1,
        onOpen: (Database db) {},
        onCreate: (Database db, int version) async {
          // Create User table for storing user info
          await db.execute('''
            CREATE TABLE User(
              id INTEGER PRIMARY KEY NOT NULL,
              first_name TEXT NOT NULL,
              last_name TEXT NOT NULL,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int)),
              last_update INT DEFAULT (cast(strftime('%s','now') as int))
            )'''
          );
          // Create Record table for storing recording info
          await db.execute('''
            CREATE TABLE Record(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              file_path TEXT,
              score REAL,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int))
            )'''
          );
          // Create Test table for storing test info
          await db.execute('''
            CREATE TABLE Test(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              score REAL,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int))
            )'''
          );
        });
  }

  Future close() async { var dbClient = await database; _database = null; return dbClient.close(); }
}

