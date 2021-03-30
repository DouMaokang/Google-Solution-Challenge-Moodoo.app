import 'dart:convert';

import 'package:flutter/material.dart';

GAD testFromMap(String str) => GAD.fromMap(json.decode(str));

String testToMap(GAD data) => json.encode(data.toMap());

class GAD {
  GAD({
    this.id,
    @required this.score,
    this.datetimeCreated,
  });

  int id;
  int score;
  int datetimeCreated;

  factory GAD.fromMap(Map<String, dynamic> json) => GAD(
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
