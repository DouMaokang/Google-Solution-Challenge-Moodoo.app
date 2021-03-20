import 'package:sqflite/sqflite.dart';

import 'package:intl/intl.dart' show DateFormat;

class AudioRecord {
  final DateTime dateTime;
  final String path;

  AudioRecord(this.dateTime, this.path);

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'dateTime': dateTime
    };
  }

}