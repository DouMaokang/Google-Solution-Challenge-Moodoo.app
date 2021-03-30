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
    String path = join(documentsDirectory.path, "TestDB9.db");
    return await openDatabase(
        path,
        version: 1,
        onOpen: (Database db) {},
        onCreate: (Database db, int version) async {
          // Create User table for storing user info
          await db.execute('''
            CREATE TABLE User(
              id INTEGER PRIMARY KEY NOT NULL,
              username TEXT NOT NULL,
              password TEXT NOT NULL,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int))
            )''');
          // Create Record table for storing recording info
          await db.execute('''
            CREATE TABLE Record(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              session_id INTEGER,
              file_path TEXT,
              score REAL,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int))
            )''');
          // Create Test table for storing GAD test info
          await db.execute('''
            CREATE TABLE GAD(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              score INTEGER,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int))
            )''');
          // Create Test table for storing PHQ test info
          await db.execute('''
            CREATE TABLE PHQ(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              score INTEGER,
              datetime_created INT DEFAULT (cast(strftime('%s','now') as int))
            )''');
          // Create table for storing session info
          await db.execute('''
            CREATE TABLE Session(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              image_path TEXT NOT NULL
            )''');

          // Sample data insertion
          await db.execute('''
            INSERT INTO Session(title, image_path) VALUES
            ("How would you describe your mood today", "assets/icons/session-1.svg"),
            ("How connected do you feel to the people around you", "assets/icons/session-2.svg"),
            ("What positive changes have you made today", "assets/icons/session-3.svg"),
            ("Who or what has made you feel good today", "assets/icons/session-4.svg"),
            ("What interesting stories have happended today", "assets/icons/session-5.svg"),
            ("Have you experienced fear or anxiety today", "assets/icons/session-6.svg"),
            ("How confident you have been feeling in your capabilities recently", "assets/icons/session-7.svg"),
            ("What makes you feel satisfied today", "assets/icons/session-8.svg"),
            ("What activies you have been involved with recently", "assets/icons/session-9.svg"),
            ("How have your sleeping habits changed recently", "assets/icons/session-10.svg"),
            ("How has your appetite recently", "assets/icons/session-11.svg"),
            ("How relaxed have you been feeling most of the time", "assets/icons/session-12.svg"),
            ("Who have you been talking to or hanging out with today", "assets/icons/session-13.svg")
          ''');

          await db.execute('''
            INSERT INTO GAD(score, datetime_created) VALUES
            (18, 1617017003),
            (21, 1616930603),
            (11, 1616844203),
            (13, 1616757803),
            (17, 1616671403),
            (20, 1616498603),
            (15, 1616325803),
            (17, 1616325803)
          ''');

          await db.execute('''
            INSERT INTO PHQ(score, datetime_created) VALUES
            (27, 1617017003),
            (25, 1616930603),
            (24, 1616844203),
            (18, 1616757803),
            (16, 1616671403),
            (10, 1616498603),
            (5, 1616325803),
            (6, 1616325803)
          ''');
        });
  }

  Future close() async { var dbClient = await database; _database = null; return dbClient.close(); }
}

