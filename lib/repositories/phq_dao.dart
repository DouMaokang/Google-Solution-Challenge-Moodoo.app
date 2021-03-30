import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/models/phq_test.dart';
import 'package:solution_challenge_2021/models/test.dart';

class PhqDAO{

  PhqDAO._();
  static final PhqDAO phqDAO = PhqDAO._();

  addTest(Test test) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into PHQ (score) VALUES 
      (${test.score})'''
    );
    return res;
  }

  getTest(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("PHQ", where: "id = ?", whereArgs: [id]);
    print(res);
    Test test = res.isNotEmpty ? Test.fromMap(res.first) : null;
    return test;
  }

  getAllTest() async {
    final db = await DBProvider.db.database;
    List<Map> list = await db.query("PHQ");
    List<PHQ> tests = [];
    for (int i = 0; i < list.length; i++) {
      tests.add(PHQ.fromMap(list[i]));
    }
    return tests;

  }

}


