import 'package:intl/intl.dart';

import '../constants/time_constants.dart';
import '../formats/default_format.dart';

class DateConverter {
  static bool isToday(int timeMills) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeMills);
    return date.isToday;
  }

  static int toMS(
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

  static String toBirthdayFromMS(int ms, [String? format]) {
    return toNameOfTimeFromMS(ms, format);
  }

  static String toBirthdayFromYMD(
    int year,
    int month,
    int day, [
    String? format,
  ]) {
    return toNameOfTimeFromYMD(year, month, day, format);
  }

  static String toNameOfTimeFromMS(int ms, [String? format]) {
    var time = DateTime.fromMillisecondsSinceEpoch(ms);
    return time.text(format);
  }

  static String toNameOfTimeFromYMD(
    int year,
    int month,
    int day, [
    String? format,
  ]) {
    if (year > 0 && month > 0 && day > 0) {
      var time = DateTime.utc(year, month, day);
      return time.text(format);
    } else {
      return '';
    }
  }

  static String toPublishTime(
    int ms, [
    String timeFormat = DefaultFormat.TIME_HMa,
    String dateFormat = DefaultFormat.DATE_DM_Y,
  ]) {
    final time = DateTime.fromMillisecondsSinceEpoch(ms);
    final int currentMS = time.millisecond;
    final int tempMS = currentMS - ms;

    const int dayMS = TimeConstrains.dayMS;
    const int hourMS = TimeConstrains.hourMS;
    const int minuteMS = TimeConstrains.minuteMS;

    final double minuteCount = tempMS / minuteMS;

    if (tempMS < minuteMS) {
      return "Now";
    } else if (tempMS < hourMS) {
      return "$minuteCount minute ago";
    } else if (tempMS < dayMS && time.isYesterday) {
      return 'Yesterday - ${time.modify(timeFormat)}';
    } else {
      return '${time.modify(dateFormat)} - ${time.modify(timeFormat)}';
    }
  }

  static String toLiveTime(int ms, [String format = DefaultFormat.DATE_DM_Y]) {
    final time = DateTime.fromMillisecondsSinceEpoch(ms);
    final int currentMS = time.millisecond;
    final int tempMS = currentMS - ms;

    final double secondCount = tempMS / TimeConstrains.secondMS;
    final double minuteCount = tempMS / TimeConstrains.minuteMS;
    final double hourCount = tempMS / TimeConstrains.hourMS;

    if (tempMS < TimeConstrains.secondMS) {
      return "Now";
    } else if (tempMS < TimeConstrains.minuteMS) {
      return "$secondCount second ago";
    } else if (tempMS < TimeConstrains.hourMS) {
      return "$minuteCount minute ago";
    } else if (tempMS < TimeConstrains.dayMS) {
      return "$hourCount hour ago";
    } else {
      return time.text(format);
    }
  }

  static String toDate(int ms, String format) {
    var time = DateTime.fromMillisecondsSinceEpoch(ms);
    return time.text(format);
  }

  static String toActiveTime(int ms) {
    final time = DateTime.fromMillisecondsSinceEpoch(ms);
    final int currentMS = time.millisecond;
    final int tempMS = currentMS - ms;

    double initTime;
    const int day = TimeConstrains.dayMS;
    const int hour = TimeConstrains.hourMS;
    const int minute = TimeConstrains.minuteMS;

    if (tempMS < minute) {
      return "Now";
    } else if (tempMS < hour) {
      initTime = tempMS / minute;
      return "${initTime.toInt()} minute ago";
    } else if (tempMS < day) {
      initTime = tempMS / hour;
      return "${initTime.toInt()} hour ago";
    } else {
      return time.text();
    }
  }
}

extension DateHelper on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String text([String? format = DefaultFormat.DATE_DM_Y, String? local]) {
    if (isToday) {
      return 'Today';
    } else if (isYesterday) {
      return 'Yesterday';
    } else {
      return DateFormat(format, local).format(this);
    }
  }

  String modify(String format, [String? local]) {
    return DateFormat(format, local).format(this);
  }
}
