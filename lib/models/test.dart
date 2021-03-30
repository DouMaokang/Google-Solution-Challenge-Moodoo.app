import 'dart:convert';

import 'package:flutter/material.dart';

Test testFromMap(String str) => Test.fromMap(json.decode(str));

String testToMap(Test data) => json.encode(data.toMap());

class Test {
  Test({
    this.id,
    @required this.score,
    this.datetimeCreated,
  });

  int id;
  double score;
  int datetimeCreated;

  factory Test.fromMap(Map<String, dynamic> json) => Test(
        id: json["id"],
        score: json["score"].toDouble(),
        datetimeCreated: json["datetime_created"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "score": score,
        "datetime_created": datetimeCreated,
      };
}
