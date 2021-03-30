import 'dart:convert';

import 'package:flutter/cupertino.dart';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.id,
    @required this.username,
    @required this.password,
    this.datetimeCreated,
  });

  int id;
  String username;
  String password;
  int datetimeCreated;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    datetimeCreated: json["datetime_created"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "password": password,
    "datetime_created": datetimeCreated,
  };
}
