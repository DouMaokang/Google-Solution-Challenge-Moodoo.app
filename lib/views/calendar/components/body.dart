import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:solution_challenge_2021/views/visualization/RecordCard.dart';
import 'package:solution_challenge_2021/views/visualization/TestCard.dart';
import 'package:solution_challenge_2021/views/calendar/components/stripe.dart';
import 'package:table_calendar/table_calendar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _selectedDate;
  DateTime _focusedDate;
  CalendarFormat _calendarFormat;
  int _numOfSessions = 1; // TODO: wire this with date

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _focusedDate = DateTime.now();
    _calendarFormat = CalendarFormat.week;
  }


  void _onSelectedDateChange(DateTime selectedDate, [bool toggleFormat=true]) {
    setState(() {
      _selectedDate = selectedDate;
      _focusedDate = selectedDate;
      if (_calendarFormat == CalendarFormat.month && toggleFormat) {
        _calendarFormat = CalendarFormat.week;
      }
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

  // TODO: change calender date background colors based on available data
  // TODO: make calendar slide continuous
  // TODO: factor out common styles (fonts and colors)
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
            CalendarStripe(onSelectedDateChange: _onSelectedDateChange, onVisibleMonthChange: _onVisibleMonthChange, calendarFormat: _calendarFormat),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 2),
                      child: Text(
                          "Summary",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: textHighlightColor, fontSize: pageTitleFontSize, fontWeight: FontWeight.bold
                          )
                      ),
                    ),
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
                        RecordCard(),
                      ],
                    ),

                    SizedBox(height: 16),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4, left: 4),
                          child: Text(
                              "PTA-5 Test",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        TestCard()
                      ],
                    ),


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
