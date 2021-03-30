import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/models/gad_test.dart';
import 'package:solution_challenge_2021/models/test.dart';

class GadDAO{

  GadDAO._();
  static final GadDAO gadDAO = GadDAO._();

  addTest(GAD test) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into GAD (score) VALUES 
      (${test.score})'''
    );
    return res;
  }

  getTest(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("GAD", where: "id = ?", whereArgs: [id]);
    print(res);
    GAD test = res.isNotEmpty ? GAD.fromMap(res.first) : null;
    return test;
  }

  getAllTest() async {
    final db = await DBProvider.db.database;
    List<Map> list = await db.query("GAD");
    List<GAD> tests = [];
    for (int i = 0; i < list.length; i++) {
      tests.add(GAD.fromMap(list[i]));
    }
    return tests;

  }

}


