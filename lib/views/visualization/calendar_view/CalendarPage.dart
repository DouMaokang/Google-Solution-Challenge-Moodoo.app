import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Not used

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  AnimationController _animationController;
  Map<DateTime, List> _events = {
    DateTime(2021, 2, 19): [88],
  };

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildHolidaysMarker() {
      return Icon(
        Icons.add_box,
        size: 20.0,
        color: Colors.blueGrey[800],
      );
    }

    Widget _buildEventsMarker(DateTime date, List events) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: _calendarController.isSelected(date)
              ? Colors.brown[500]
              : _calendarController.isToday(date)
                  ? Colors.brown[300]
                  : Colors.blue[400],
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }

    CalendarBuilders _calendarBuilder = CalendarBuilders(
      dayBuilder: (context, date, _) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
//          color: Colors.deepOrange[300],
          width: 100,
          height: 100,
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        );
      },
      holidayDayBuilder: (context, date, _) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
          color: Colors.deepOrange[300],
          width: 100,
          height: 100,
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        );
      },
      todayDayBuilder: (context, date, _) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
          color: Colors.amber[400],
          width: 100,
          height: 100,
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        );
      },
//      markersBuilder: (context, date, events, holidays) {
//        final children = <Widget>[];
//
//        if (events.isNotEmpty) {
//          children.add(
//            Positioned(
//              right: 1,
//              bottom: 1,
//              child: _buildEventsMarker(date, events),
//            ),
//          );
//        }
//
//        if (holidays.isNotEmpty) {
//          children.add(
//            Positioned(
//              right: -2,
//              top: -2,
//              child: _buildHolidaysMarker(),
//            ),
//          );
//        }
//
//        return children;
//      },
    );

    return Container(
      child: TableCalendar(
        holidays: _events,
        calendarController: _calendarController,
        availableGestures: AvailableGestures.horizontalSwipe,
        weekendDays: [],
        builders: _calendarBuilder,
        headerStyle: HeaderStyle(formatButtonVisible: false),
        calendarStyle: CalendarStyle(
          contentDecoration: BoxDecoration(
//              color: Colors.greenAccent
              ),
          outsideDaysVisible: false,
          highlightSelected: false,
        ),
        onVisibleDaysChanged: (first, last, format){
          // _animationController.animationBehavior
        },
      ),
    );
  }
}
