import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/models/session.dart';

class SessionDAO {
  SessionDAO._();

  static final SessionDAO sessionDAO = SessionDAO._();

  getSession(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("Session", where: "id = ?", whereArgs: [id]);
    print(res);
    Session session = res.isNotEmpty ? Session.fromMap(res.first) : null;
    return session;
  }

  getAllSession() async {
    final db = await DBProvider.db.database;
    var res = await db.query("Session");
    return res;
  }
}
