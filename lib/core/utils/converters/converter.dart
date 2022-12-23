import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/providers/time_provider.dart';
import 'package:flutter_utils/core/utils/validators/validator.dart';

class Converter {
  const Converter._();

  static String asString(dynamic data) {
    if (data is List<String>) {
      String buffer = '';
      if (data.isNotEmpty) {
        int size = data.length;
        int end = size - 1;
        int and = size - 2;
        for (int index = 0; index < size; index++) {
          if (index == and) {
            buffer = '$buffer${data[index]} and ';
          } else if (index == end) {
            buffer = '$buffer${data[index]}';
          } else {
            buffer = '$buffer${data[index]}, ';
          }
        }
        for (String value in data) {
          if (Validator.isValidString(value)) {
            buffer = '$buffer, $value';
          }
        }
      }
      return buffer;
    } else {
      return data != null ? data.toString() : '';
    }
  }

  static int toInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else {
      return 0;
    }
  }

  static double toDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }

  static int toDay(int timeMills) {
    return TimeProvider.toDay(timeMills);
  }

  static int toMonth(int timeMills) {
    return TimeProvider.toMonth(timeMills);
  }

  static int toYear(int timeMills) {
    return TimeProvider.toYear(timeMills);
  }

  static String toDigit(String? value) {
    String buffer = '';

    if (value != null) {
      for (String character in value.characters) {
        if (Validator.isDigit(character)) {
          buffer = '$buffer$character';
        }
      }
    }

    return buffer;
  }

  static String toNumeric(String? value) {
    String buffer = '';

    if (value != null) {
      for (String character in value.characters) {
        if (Validator.isNumeric(character)) {
          buffer = '$buffer$character';
        }
      }
    }

    return buffer;
  }

  static String toDigitWithPlus(String? value) {
    String buffer = '';

    if (value != null) {
      for (String character in value.characters) {
        if (character == '+' || Validator.isDigit(character)) {
          buffer = '$buffer$character';
        }
      }
    }

    return buffer;
  }

  static String toDigitWithLetter(String? value) {
    String buffer = '';

    if (value != null) {
      for (String character in value.characters) {
        if (Validator.isDigit(character) || Validator.isLetter(character)) {
          buffer = '$buffer$character';
        }
      }
    }

    return buffer;
  }

  static String toLetter(String? value) {
    String buffer = '';

    if (value != null) {
      for (String character in value.characters) {
        if (Validator.isLetter(character)) {
          buffer = '$buffer$character';
        }
      }
    }

    return buffer;
  }

  static List<T> toList<T>(T cls, List<dynamic> list) {
    final List<T> convertedList = [];
    if (Validator.isValidList(list)) {
      for (dynamic data in list) {
        if (Validator.isInstance(data, cls)) {
          convertedList.add(data as T);
        }
      }
    }
    return convertedList;
  }
}
