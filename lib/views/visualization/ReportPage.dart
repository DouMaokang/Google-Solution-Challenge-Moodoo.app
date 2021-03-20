import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/views/visualization/weekly_view/BarChart.dart';
import 'package:solution_challenge_2021/views/visualization/weekly_view/LineChart.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: const Text('AppBar'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.calendar_today_outlined),
//            tooltip: 'Calendar',
//            onPressed: null,
//          ),
//        ],
//      ),
      body:SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Statistics',
                      style: TextStyle(
                          color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  LineChartSample1(),
                  SizedBox(height: 8),
                  BarChartSample1(),

                ]),
          ),
        ),
      ),

    );
  }
}
