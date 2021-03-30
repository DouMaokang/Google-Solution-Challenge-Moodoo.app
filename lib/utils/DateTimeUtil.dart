class DateTimeUtil {
  static bool compareDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static String mapWeekOfDay(int weekday) {
    List<String> dayOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    try {
      return dayOfWeek[weekday - 1];
    } catch (e) {
      throw ("Index error: passed in weekday = $weekday");
    }
  }

  static String mapMonth(int month) {
    List<String> months = [
      'January',
      'Febrary',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'Spetember',
      'October',
      'November',
      'Decomber'
    ];
    try {
      return months[month - 1];
    } catch (e) {
      throw ("Index error: passed in month = $month");
    }
  }

  static String dateToString(DateTime date, [bool withWeekOfDay = false]) {
    String s = withWeekOfDay
        ? compareDate(date, DateTime.now())
            ? 'Today, '
            : '${mapWeekOfDay(date.weekday)}, '
        : '';

    s += date.day.toString() + ' ';
    s += mapMonth(date.month) + ' ';
    s += date.year.toString();
    return s;
  }
}
