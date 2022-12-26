class DateProvider {
  const DateProvider._();

  static int msFromUTC(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
  ]) {
    var time = DateTime.utc(year, month - 1, day, hour, minute, second);
    return time.millisecond;
  }

  static int msFromSource(String source) {
    var time = DateTime.tryParse(source) ?? DateTime.now();
    return time.millisecond;
  }

  static int currentMS() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static int currentDay() {
    return DateTime.now().day;
  }

  static int currentMonth() {
    return DateTime.now().month;
  }

  static int currentYear() {
    return DateTime.now().year;
  }

  static int toDay(int timeMills) {
    return DateTime.fromMillisecondsSinceEpoch(timeMills).day;
  }

  static int toMonth(int timeMills) {
    return DateTime.fromMillisecondsSinceEpoch(timeMills).month;
  }

  static int toYear(int timeMills) {
    return DateTime.fromMillisecondsSinceEpoch(timeMills).year;
  }

  static DateTime toDateTime(int? timeMills) {
    return DateTime.fromMillisecondsSinceEpoch(timeMills ?? currentMS());
  }
}
