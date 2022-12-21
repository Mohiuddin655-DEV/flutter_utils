class TimeProvider {
  const TimeProvider._();

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
}
