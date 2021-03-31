import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  List _date = [];

  Future<Database> get database async {

    for (int i = 0; i < 30; i++) {
      _date.add(DateTime.now().subtract(new Duration(days: i)).millisecondsSinceEpoch ~/ 1000);
    }

    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }



  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Demo-2.db");
    return await openDatabase(path, version: 1, onOpen: (Database db) {},
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
            INSERT INTO Record(session_id, datetime_created, score) VALUES
            (1, ${_date[29]}, 4.3),
            (2, ${_date[28]}, 5.6),
            (3, ${_date[27]}, 12.4),
            (4, ${_date[26]}, 13.6),
            (5, ${_date[25]}, 13.5),
            (6, ${_date[24]}, 5.6),
            (7, ${_date[23]}, 3.2),
            (8, ${_date[22]}, 20.1),
            (9, ${_date[21]}, 18.0),
            (10, ${_date[20]}, 19.2),
            (11, ${_date[19]}, 12.0),
            (12, ${_date[18]}, 11.0),
            (13, ${_date[17]}, 11.0),
            (1, ${_date[16]}, 11.0),
            (2, ${_date[15]}, 16.2),
            (3, ${_date[14]}, 15.2),
            (4, ${_date[13]}, 11.2),
            (5, ${_date[12]}, 9.2),
            (6, ${_date[11]}, 10.2),
            (13, ${_date[10]}, 11.2),
            (12, ${_date[9]}, 12.2),
            (10, ${_date[20]}, 13.2),
            (11, ${_date[19]}, 15.2),
            (12, ${_date[18]}, 16.2),
            (13, ${_date[17]}, 21.2),
            (1, ${_date[16]}, 16.2),
            (2, ${_date[15]}, 15.2),
            (3, ${_date[14]}, 14.2),
            (4, ${_date[13]}, 12.2),
            (5, ${_date[12]}, 0.2),
            (6, ${_date[11]}, 2.2),
            (13, ${_date[10]}, 3.2),
            (12, ${_date[9]}, 3.2),
            (11, ${_date[8]}, 3.2),
            (8, ${_date[7]}, 6.2),
            (5, ${_date[6]}, 8.2),
            (6, ${_date[5]}, 15.2),
            (7, ${_date[4]}, 14.2),
            (3, ${_date[3]}, 12.2),
            (12, ${_date[2]}, 6.2),
            (11, ${_date[1]}, 3.2)
          ''');

      await db.execute('''
            INSERT INTO GAD(score, datetime_created) VALUES
            (15, ${_date[0]}),
            (16, ${_date[1]}),
            (17, ${_date[2]}),
            (13, ${_date[3]}),
            (12, ${_date[4]}),
            (11, ${_date[5]}),
            (8, ${_date[6]}),
            (5, ${_date[7]}),
            (5, ${_date[8]})
          ''');

      await db.execute('''
            INSERT INTO PHQ(score, datetime_created) VALUES
            (10, ${_date[0]}),
            (11, ${_date[1]}),
            (12, ${_date[2]}),
            (10, ${_date[3]}),
            (11, ${_date[4]}),
            (12, ${_date[5]}),
            (8, ${_date[6]}),
            (9, ${_date[7]}),
            (8, ${_date[8]})

          ''');
    });
  }

  Future close() async {
    var dbClient = await database;
    _database = null;
    return dbClient.close();
  }
}
