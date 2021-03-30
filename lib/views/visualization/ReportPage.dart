import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/helper/global.dart';
import 'package:solution_challenge_2021/models/gad_test.dart';
import 'package:solution_challenge_2021/models/phq_test.dart';
import 'package:solution_challenge_2021/models/record.dart';
import 'package:solution_challenge_2021/repositories/gad_dao.dart';
import 'package:solution_challenge_2021/repositories/phq_dao.dart';
import 'package:solution_challenge_2021/repositories/record_dao.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';
import 'package:solution_challenge_2021/views/visualization/weekly_view/GAD7Chart.dart';
import 'package:solution_challenge_2021/views/visualization/weekly_view/PHQ9Chart.dart';

import '../constants.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Future<Map> _getData() async {
    String username = Global.global.getUsername();

    Map<String, int> days = {};

    List<Record> recordList = await RecordDAO.recordDAO.getAllRecord();
    List<GAD> gadList = await GadDAO.gadDAO.getAllTest();
    List<PHQ> phqList = await PhqDAO.phqDAO.getAllTest();

    if (recordList != null) {
      for (int i = 0; i < recordList.length; i++) {
        Record record = recordList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            record.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (!days.containsKey(dateString)) {
          days[dateString] = 1;
        }
      }
    }
    if (gadList != null) {
      for (int i = 0; i < gadList.length; i++) {
        GAD test = gadList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            test.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (!days.containsKey(dateString)) {
          days[dateString] = 1;
        }
      }
    }
    if (phqList != null) {
      for (int i = 0; i < phqList.length; i++) {
        PHQ test = phqList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            test.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (!days.containsKey(dateString)) {
          days[dateString] = 1;
        }
      }
    }

    print(days);
    return {
      "username": username,
      "sessions": recordList.length + gadList.length + phqList.length,
      "days": days.length
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("");
            } else if (snapshot.hasData) {
              var _username = snapshot.data["username"];
              var _sessions = snapshot.data["sessions"];
              var _days = snapshot.data["days"];
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.green.shade800,
                              child: Text(
                                '${_username[0].toUpperCase()}${_username[1].toUpperCase()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              radius: 46,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Session trained",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${_sessions} ${_sessions > 1 ? "sessions" : "session"}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: textPrimaryColor,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Daily streak",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${_days} ${_days > 1 ? "days" : "day"}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: textPrimaryColor,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 32,
                          ),
                          GAD7Chart(),
                          SizedBox(height: 16),
                          PHQ9Chart(),
                        ]),
                  ),
                ),
              );
            } else {
              return Text("");
            }
          }),
    );
  }
}
