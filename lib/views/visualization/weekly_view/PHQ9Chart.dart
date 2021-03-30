import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/models/gad_test.dart';
import 'package:solution_challenge_2021/models/phq_test.dart';
import 'package:solution_challenge_2021/models/test.dart';
import 'package:solution_challenge_2021/repositories/gad_dao.dart';
import 'package:solution_challenge_2021/repositories/phq_dao.dart';
import 'package:solution_challenge_2021/repositories/test_dao.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';
import 'package:solution_challenge_2021/views/constants.dart';

class PHQ9Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PHQ9ChartState();
}

class PHQ9ChartState extends State<PHQ9Chart> {
  Future _getData() async {
    var data = {};
    List<PHQ> testList = await PhqDAO.phqDAO.getAllTest();
    print(testList[0].toMap().toString());
    if (testList != null) {
      for (int i = 0; i < testList.length; i++) {
        PHQ test = testList[i];
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(test.datetimeCreated * 1000);
        String dateString = DateTimeUtil.dateToString(date);
        if (! data.containsKey(dateString)) {
          data[dateString] = {
            "avg_score": 0.0,
            "test": []
          };
        }
        data[dateString]["test"].add(test);
      }

      // Compute average score of a date
      data.forEach((key, value) {
        var testList = value["test"];
        double totalScore = 0.0;
        int numOfScores = 0;
        testList.forEach((element) {
          if (element.score != null) {
            numOfScores += 1;
            totalScore += element.score.toDouble();
          }
        });
        data[key]["avg_score"] = totalScore / numOfScores;
      });
    }
    return data;
  }

  _getPast7DaysData(Map tests) {
    print("!");
    List<FlSpot> scores = [];
    var sevenDaysAgo = DateTime.now().subtract(new Duration(days: 6));
    int dayOfWeek = sevenDaysAgo.weekday;
    for (int i = 0; i < 7; i++) {
      var date = sevenDaysAgo.add(new Duration(days: i));
      double score = 0.0;
      if (tests.containsKey(DateTimeUtil.dateToString(date))) {
        score = tests[DateTimeUtil.dateToString(date)]["avg_score"];
      }
      scores.add(FlSpot((dayOfWeek + i).toDouble(), score.toDouble()));
    }

    print("!!");

    print(scores);

    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: scores,
      isCurved: true,
      colors: gradientColors,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

  bool isShowingWeeklyData;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.22,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Text("");
              } else if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'PHQ-9 Score',
                            style: TextStyle(
                                color: textPrimaryColor, fontSize: titleFontSize, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${DateTimeUtil.dateToString(DateTime.now().subtract(new Duration(days: 6)))} ~ ${DateTimeUtil.dateToString(DateTime.now())}',
                            style: TextStyle(
                                color: const Color(0xff827daa), fontSize: titleFontSize, fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0, left: 0.0),
                              child: LineChart(
                                sampleData1(_getPast7DaysData(snapshot.data)),
                                swapAnimationDuration: const Duration(milliseconds: 250),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text("");
              }
            }


        ),
      ),
    );
  }

  LineChartData sampleData1(List<LineChartBarData> barData) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
              case 8:
                return 'M';
              case 2:
              case 9:
                return 'T';
              case 3:
              case 10:
                return 'W';
              case 4:
              case 11:
                return 'T';
              case 5:
              case 12:
                return 'F';
              case 6:
              case 13:
                return 'S';
              case 7:
              case 14:
                return 'S';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 5:
                return '5';
              case 10:
                return '10';
              case 15:
                return '15';
              case 20:
                return '20';
              case 25:
                return '25';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: DateTime.now().subtract(new Duration(days: 6)).weekday.toDouble(),
      maxX: DateTime.now().subtract(new Duration(days: 6)).weekday.toDouble() + 6,
      maxY: 27,
      minY: 0,
      lineBarsData: barData,
    );
  }
}