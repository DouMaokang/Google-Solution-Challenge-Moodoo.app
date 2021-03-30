// To parse this JSON data, do
//
//     final record = recordFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

Record recordFromMap(String str) => Record.fromMap(json.decode(str));

String recordToMap(Record data) => json.encode(data.toMap());

class Record {
  Record({
    this.id,
    @required this.sessionId,
    @required this.filePath,
    this.score,
    this.datetimeCreated,
  });

  int id;
  int sessionId;
  String filePath;
  double score;
  int datetimeCreated;

  factory Record.fromMap(Map<String, dynamic> json) => Record(
        id: json["id"],
        sessionId: json["session_id"],
        filePath: json["file_path"],
        score: json["score"] == null ? null : json["score"].toDouble(),
        datetimeCreated: json["datetime_created"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "session_id": sessionId,
        "file_path": filePath,
        "score": score == null ? null : score,
        "datetime_created": datetimeCreated,
      };
}
