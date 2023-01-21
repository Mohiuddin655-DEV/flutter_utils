import 'package:flutter_utils/core/utils/constants/replacements.dart';

import '../validators/validator.dart';

class Replacement {
  const Replacement._();

  static String auto(String value) {
    for (int index = 0; index < value.length; index++) {
      for (String regex in Replacements.none) {
        value = value.replaceAll(regex, "");
      }
      for (String regex in Replacements.slash) {
        value = value.replaceAll(regex, "_");
      }
    }
    return value;
  }

  static String specific(String value, String replacement, List<String> regexList) {
    if (regexList.isNotEmpty) {
      for (String regex in regexList) {
        value = value.replaceAll(regex, replacement);
      }
    }
    return value;
  }

  static String custom(String value, List<String> replacements, List<String> regexList) {
    if (regexList.isNotEmpty &&
        Validator.isMatched(replacements.length, regexList.length)) {
      for (int index = 0; index < value.length; index++) {
        value = value.replaceAll(regexList[index], replacements[index]);
      }
    }
    return value;
  }
}
