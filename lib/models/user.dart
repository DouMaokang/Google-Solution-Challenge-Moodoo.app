import 'dart:convert';

import 'package:flutter/cupertino.dart';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    this.datetimeCreated,
    this.lastUpdate,
  });

  int id;
  String firstName;
  String lastName;
  int datetimeCreated;
  int lastUpdate;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    datetimeCreated: json["datetime_created"],
    lastUpdate: json["last_update"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "datetime_created": datetimeCreated,
    "last_update": lastUpdate,
  };
}
