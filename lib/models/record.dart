// To parse this JSON data, do
//
//     final record = recordFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Record recordFromMap(String str) => Record.fromMap(json.decode(str));

String recordToMap(Record data) => json.encode(data.toMap());

class Record {
  Record({
    this.id,
    @required this.filePath,
    this.score,
    this.datetimeCreated,
  });

  int id;
  String filePath;
  double score;
  int datetimeCreated;

  factory Record.fromMap(Map<String, dynamic> json) => Record(
    id: json["id"],
    filePath: json["file_path"],
    score: json["score"].toDouble(),
    datetimeCreated: json["datetime_created"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "file_path": filePath,
    "score": score,
    "datetime_created": datetimeCreated,
  };
}
