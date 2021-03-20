import 'package:solution_challenge_2021/helper/Database.dart';
import 'package:solution_challenge_2021/models/record.dart';

class RecordDAO{

  RecordDAO._();
  static final RecordDAO userDAO = RecordDAO._();

  addRecord(Record record) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT Into Record (file_path) VALUES 
      (${record.filePath})'''
    );
    return res;
    // TODO: get record id
  }

  updateRecordScore(Record record) async {
    final db = await DBProvider.db.database;
    var res = await db.rawUpdate('''
      UPDATE Record SET score = ? WHERE id = ?''',
      [record.score, record.id]
    );
    return res;
  }
}


