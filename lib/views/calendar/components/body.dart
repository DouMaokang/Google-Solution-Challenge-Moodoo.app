import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/models/record.dart';
import 'package:solution_challenge_2021/models/test.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:solution_challenge_2021/views/calendar/components/RecordCard.dart';
import 'package:solution_challenge_2021/views/visualization/TestCard.dart';
import 'package:solution_challenge_2021/views/calendar/components/stripe.dart';
import 'package:table_calendar/table_calendar.dart';

class Body extends StatefulWidget {
  final data;
  Body({Key key, @required this.data}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _selectedDate;
  DateTime _focusedDate;
  CalendarFormat _calendarFormat;
  Map<String, double> _depressionScore = {};
  var _records;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _focusedDate = DateTime.now();
    _calendarFormat = CalendarFormat.week;
    widget.data.forEach((key, value) {
      _depressionScore[key] = value["avg_score"];
    });
    String dateString = DateTimeUtil.dateToString(_selectedDate);
    _records = widget.data[dateString] == null ? null : widget.data[dateString]["record"];
  }


  void _onSelectedDateChange(DateTime selectedDate, [bool toggleFormat=true]) {
    setState(() {
      _selectedDate = selectedDate;
      _focusedDate = selectedDate;
      if (_calendarFormat == CalendarFormat.month && toggleFormat) {
        _calendarFormat = CalendarFormat.week;
      }
      String dateString = DateTimeUtil.dateToString(_selectedDate);
      _records = widget.data[dateString] == null ? null : widget.data[dateString]["record"];
    });
  }

  void _onClickCalendarFormat() {
    setState(() {
      _calendarFormat = (_calendarFormat == CalendarFormat.week)
          ? CalendarFormat.month
          : CalendarFormat.week;
    });
  }

  void _onVisibleMonthChange(DateTime first) {
    setState(() {
      _focusedDate = first;
    });
  }

  Widget _getRecordCards(List recordList)
  {
    if (recordList != null) {
      List<Widget> list = [];
      for(var i = 0; i < recordList.length; i++){
        list.add(new RecordCard(record: recordList[i]));
      }
      return new Column(children: list);
    }
    return new Container(padding: EdgeInsets.only(top: 256), child: Center(child: Text("No recordings")),);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: new IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: new Icon(Icons.arrow_back_ios, color: iconPrimaryColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                (_calendarFormat == CalendarFormat.week)
                    ? DateTimeUtil.dateToString(_selectedDate, true)
                    : '${DateTimeUtil.mapMonth(_focusedDate.month)} ${_focusedDate.year}',
                style: TextStyle(color: Colors.black, fontSize: titleFontSize),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.calendar_today,
                    color: iconPrimaryColor,
                  ),
                  onPressed: _onClickCalendarFormat,
                )
              ],
            ),
            CalendarStripe(onSelectedDateChange: _onSelectedDateChange, onVisibleMonthChange: _onVisibleMonthChange, calendarFormat: _calendarFormat, depressionScore: _depressionScore,),
            Divider(
              height: 1,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              // color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4, left: 2),
                          child: Text(
                              "Recording",
                              style: TextStyle(
                                  color: Colors.black, fontSize: sessionTitleFontSize, fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        _getRecordCards(_records)
                      ]
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
