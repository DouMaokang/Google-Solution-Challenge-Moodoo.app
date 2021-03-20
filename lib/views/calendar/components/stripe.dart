import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:table_calendar/table_calendar.dart';


// TODO: do not allow select future dates
// TODO: do not allow swipe to future calendar pages
// TODO: create data structure for storing depression scores
// TODO: check date comparison

final Map<String, double> depressionScore = {
  DateTimeUtil.dateToString(DateTime(2021, 3, 4)): 1,
  DateTimeUtil.dateToString(DateTime(2021, 3, 5)): 3,
  DateTimeUtil.dateToString(DateTime(2021, 3, 6)): 8,
  DateTimeUtil.dateToString(DateTime(2021, 3, 7)): 9,
  DateTimeUtil.dateToString(DateTime(2021, 3, 8)): 8,
  DateTimeUtil.dateToString(DateTime(2021, 3, 9)): 7,
  DateTimeUtil.dateToString(DateTime(2021, 3, 10)): 5,
  DateTimeUtil.dateToString(DateTime(2021, 3, 11)): 1,
  DateTimeUtil.dateToString(DateTime(2021, 3, 12)): 3,
  DateTimeUtil.dateToString(DateTime(2021, 3, 13)): 8,
  DateTimeUtil.dateToString(DateTime(2021, 3, 14)): 9,
  DateTimeUtil.dateToString(DateTime(2021, 3, 15)): 8,
  DateTimeUtil.dateToString(DateTime(2021, 3, 16)): 7,
  DateTimeUtil.dateToString(DateTime(2021, 3, 17)): 5,
  DateTimeUtil.dateToString(DateTime(2021, 3, 18)): 1,
  DateTimeUtil.dateToString(DateTime(2021, 3, 19)): 3,
  DateTimeUtil.dateToString(DateTime(2021, 3, 20)): 8,
};

class CalendarStripe extends StatefulWidget {
  final Function onSelectedDateChange;
  final Function onVisibleMonthChange;
  final CalendarFormat calendarFormat;

  CalendarStripe(
      {this.onSelectedDateChange,
      this.onVisibleMonthChange,
      this.calendarFormat});

  @override
  _CalendarStripeState createState() => _CalendarStripeState();
}

class _CalendarStripeState extends State<CalendarStripe> {
  CalendarController _calendarController;
  AnimationController _animationController;
  CalendarFormat _prevCalendarFormat;

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
  void didUpdateWidget(CalendarStripe oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _prevCalendarFormat = oldWidget.calendarFormat;
    });
    _calendarController.setCalendarFormat(widget.calendarFormat);
  }

  double _computePercentage(DateTime date) {
    String dateString = DateTimeUtil.dateToString(date.toUtc());
    if (depressionScore[dateString] != null) {
      return depressionScore[dateString] / 10.0;
    }
    return 0;
  }

  CalendarBuilders _calendarBuilder() {

    Widget _commonBuilder({date, center}) {
      return (
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            rotateLinearGradient: true,
            linearGradient: LinearGradient(
              colors: [
                calendarGradientStart,
                calendarGradientEnd
              ],
            ),
            animation: true,
            radius: 40.0,
            lineWidth: 5.0,
            percent: _computePercentage(date),
            backgroundColor: Colors.white,
            center: center,
          )
      );
    }

    return CalendarBuilders(
      todayDayBuilder: (context, date, _) {
        return _commonBuilder(
          date: date,
          center: Stack(
            alignment: Alignment.center,
            children: [
              Text('${date.day}',
                  style: TextStyle(fontSize: secondaryTextFontSize, color: Colors.red),
                  textAlign: TextAlign.center),
            ],
          ),
        );
      },
      selectedDayBuilder: (context, date, _) {
        return _commonBuilder(
          date: date,
          center: Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('${date.day}',
                    style: TextStyle(
                      fontSize: secondaryTextFontSize,
                      color: DateTimeUtil.compareDate(date, DateTime.now())
                          ? Colors.red
                          : Colors.black
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
      dayBuilder: (context, date, _) {

        return _commonBuilder(
          date: date,
          center: Stack(
            alignment: Alignment.center,
            children: [
              Text('${date.day}',
                  style: TextStyle(fontSize: secondaryTextFontSize),
                  textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(depressionScore);
    return Container(
      child: TableCalendar(
        initialCalendarFormat: widget.calendarFormat,
        headerVisible: false,
        rowHeight: 60,
        builders: _calendarBuilder(),
        calendarController: _calendarController,
        availableGestures: AvailableGestures.horizontalSwipe,
        weekendDays: [],
        calendarStyle: CalendarStyle(
          renderDaysOfWeek: true,
          contentDecoration: BoxDecoration(color: Colors.transparent),
          outsideDaysVisible: false,
        ),
        onDaySelected: (date, events, holidays) =>
            widget.onSelectedDateChange(date),
        onVisibleDaysChanged: (first, last, format) {
          // execute when swiping
          // do not execute when toggling the calendar format
          if (this._prevCalendarFormat == format ||
              this._prevCalendarFormat == null) {
            DateTime curSelected = _calendarController.selectedDay;
            if (format == CalendarFormat.week) {
              // swipe in week format
              DateTime selectedDateAfterSwipe =
                  first.add(new Duration(days: curSelected.weekday));
              _calendarController.setSelectedDay(selectedDateAfterSwipe);
              widget.onSelectedDateChange(
                  _calendarController.selectedDay, false);
            } else {
              // swipe in month format
              widget.onVisibleMonthChange(first);
            }
          } else {
            // show selected date
            _calendarController.setFocusedDay(_calendarController.selectedDay);
            setState(() {
              _prevCalendarFormat = format;
            });
          }
        },
      ),
    );
  }
}
