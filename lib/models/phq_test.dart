import 'dart:convert';

import 'package:flutter/material.dart';

PHQ testFromMap(String str) => PHQ.fromMap(json.decode(str));

String testToMap(PHQ data) => json.encode(data.toMap());

class PHQ {
  PHQ({
    this.id,
    @required this.score,
    this.datetimeCreated,
  });

  int id;
  int score;
  int datetimeCreated;

  factory PHQ.fromMap(Map<String, dynamic> json) => PHQ(
    id: json["id"],
    score: json["score"],
    datetimeCreated: json["datetime_created"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "score": score,
    "datetime_created": datetimeCreated,
  };
}
