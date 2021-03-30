import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/models/user.dart';

class UserDAO{

  UserDAO._();
  static final UserDAO userDAO = UserDAO._();

  addUser(User user) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into User(id, username, password) VALUES(${user.id}, '${user.username}', "${user.password}")'''
    );
    return res;
  }

  getUser(String username) async {
    final db = await DBProvider.db.database;
    var res = await db.query("User", where: "username = ?", whereArgs: [username]);
    User user = res.isNotEmpty ? User.fromMap(res.first) : null;
    print(user.toMap().toString());
    return user;
  }

  getAllUser() async {
    final db = await DBProvider.db.database;
    var res = await db.query("User");
    print(res);
    // return res;
  }
}


