import 'package:solution_challenge_2021/helper/Database.dart';
import 'package:solution_challenge_2021/models/test.dart';

class TestDAO{

  TestDAO._();
  static final TestDAO userDAO = TestDAO._();

  addTest(Test test) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into Test (score) VALUES 
      (${test.score})'''
    );
    return res;
  }
}


