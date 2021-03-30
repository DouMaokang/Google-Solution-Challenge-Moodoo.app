import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/models/test.dart';

class TestDAO {
  TestDAO._();

  static final TestDAO testDAO = TestDAO._();

  addTest(Test test) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into Test (score) VALUES 
      (${test.score})''');
    return res;
  }

  getTest(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("Test", where: "id = ?", whereArgs: [id]);
    print(res);
    Test test = res.isNotEmpty ? Test.fromMap(res.first) : null;
    return test;
  }

  getAllTest() async {
    final db = await DBProvider.db.database;
    List<Map> list = await db.query("Test");
    List<Test> tests = [];
    for (int i = 0; i < list.length; i++) {
      tests.add(Test.fromMap(list[i]));
    }
    return tests;
  }
}
