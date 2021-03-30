import 'dart:convert';

import 'package:meta/meta.dart';

Session sessionFromMap(String str) => Session.fromMap(json.decode(str));

String sessionToMap(Session data) => json.encode(data.toMap());

class Session {
  Session({@required this.id, @required this.title, @required this.imagePath});

  final int id;
  final String title;
  final String imagePath;

  factory Session.fromMap(Map<String, dynamic> json) => Session(
      id: json["id"], title: json["title"], imagePath: json['image_path']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "image_path": imagePath,
      };
}
