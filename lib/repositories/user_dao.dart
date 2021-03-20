import 'package:solution_challenge_2021/helper/Database.dart';
import 'package:solution_challenge_2021/models/user.dart';

class UserDAO{

  UserDAO._();
  static final UserDAO userDAO = UserDAO._();

  addUser(User user) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into User(id, first_name, last_name) VALUES(${user.id}, '${user.firstName}', '${user.lastName}')'''
    );
    return res;
  }

  updateUser(User user) async {
    final db = await DBProvider.db.database;
    var res = await db.rawUpdate('''
      UPDATE User SET first_name = ?, last_name = ?, last_update = ? WHERE id = ?''',
     [user.firstName, user.lastName, DateTime.now().toUtc().millisecondsSinceEpoch, user.id]
    );
    return res;
  }

  getUser(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("User", where: "id = ?", whereArgs: [id]);
    print(res);
    User user = res.isNotEmpty ? User.fromMap(res.first) : null;
    return user;
  }

  getAllUser() async {
    final db = await DBProvider.db.database;
    var res = await db.query("User");
    print(res);
    // return res;
  }
}


