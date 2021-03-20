import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:solution_challenge_2021/models/audio_record.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  void createDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'flutter_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE records(path STRING PRIMARY KEY, dataTime DATETIME)",
        );
      },
    );

  }

  // Define a function that inserts xx into the database
  Future<void> insertRecord(AudioRecord record, String database) async {
    // Get a reference to the database.
    final Database db = await openDatabase(database);

    // Insert the xx into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same xx is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'records',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}