import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/models/gad_test.dart';
import 'package:solution_challenge_2021/models/phq_test.dart';
import 'package:solution_challenge_2021/models/record.dart';
import 'package:solution_challenge_2021/models/test.dart';
import 'package:solution_challenge_2021/repositories/gad_dao.dart';
import 'package:solution_challenge_2021/repositories/phq_dao.dart';
import 'package:solution_challenge_2021/repositories/record_dao.dart';
import 'package:solution_challenge_2021/repositories/test_dao.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';

import '../constants.dart';
import 'components/body.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  Future<Map> getData() async {
    /**
     * data = {
     *  date: {
     *      record: []
     *      test: []
     *    }
     * }
     */
    Map<String, Map> data = {};

    List<Record> recordList = await RecordDAO.recordDAO.getAllRecord();
    List<GAD> gadList = await GadDAO.gadDAO.getAllTest();
    List<PHQ> phqList = await PhqDAO.phqDAO.getAllTest();

    if (recordList != null) {
      for (int i = 0; i < recordList.length; i++) {
        Record record = recordList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(record.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (! data.containsKey(dateString)) {
          data[dateString] = {
            "avg_score": 0.0,
            "record": [],
            "gad": [],
            "phq": []
          };
        }
        data[dateString]["record"].add(record);
        print(record.toMap().toString());
      }

      // Compute average score of a date
      data.forEach((key, value) {
        var recordList = value["record"];
        double totalScore = 0.0;
        int numOfScores = 0;
        recordList.forEach((element) {
          if (element.score != null) {
            numOfScores += 1;
            totalScore += element.score;
          }
        });
        data[key]["avg_score"] = totalScore / numOfScores;
      });
    }

    if (gadList != null) {
      for (int i = 0; i < gadList.length; i++) {
        GAD test = gadList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(test.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (! data.containsKey(dateString)) {
          data[dateString] = {
            "avg_score": 0.0,
            "record": [],
            "gad": [],
            "phq": []
          };
        }
        data[dateString]["gad"].add(test);
      }
    }
    if (phqList != null) {
      for (int i = 0; i < phqList.length; i++) {
        PHQ test = phqList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(test.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (! data.containsKey(dateString)) {
          data[dateString] = {
            "avg_score": 0.0,
            "record": [],
            "gad": [],
            "phq": []
          };
        }
        data[dateString]["phq"].add(test);
      }
    }

    print(data);


    return data;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          } else if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Body(data: snapshot.data),
            );
          } else {
            return Text("loading");
          }
        }
    );
  }
}
