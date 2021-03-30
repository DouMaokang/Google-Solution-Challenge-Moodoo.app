import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/models/record.dart';

class RecordDAO {
  RecordDAO._();

  static final RecordDAO recordDAO = RecordDAO._();

  addRecord(Record record) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert('''
      INSERT INTO Record(session_id, file_path) VALUES 
      (${record.sessionId}, '${record.filePath}')''');
    return res;
  }

  updateRecordScore(Record record) async {
    final db = await DBProvider.db.database;
    var res = await db.rawUpdate('''
      UPDATE Record SET score = ? WHERE id = ?''', [record.score, record.id]);
    return res;
  }

  getRecord(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("Record", where: "id = ?", whereArgs: [id]);
    print(res);
    Record record = res.isNotEmpty ? Record.fromMap(res.first) : null;
    return record;
  }

  getAllRecord() async {
    final db = await DBProvider.db.database;
    List<Map> list = await db.query("Record");
    List<Record> records = [];
    for (int i = 0; i < list.length; i++) {
      records.add(Record.fromMap(list[i]));
    }
    return records;
  }
}
