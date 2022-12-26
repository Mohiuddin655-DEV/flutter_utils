import 'package:flutter_utils/core/utils/formats/default_format.dart';
import 'package:intl/intl.dart';

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

  String format(String format, [String? local]) {
    return DateFormat(format, local).format(this);
  }
}
