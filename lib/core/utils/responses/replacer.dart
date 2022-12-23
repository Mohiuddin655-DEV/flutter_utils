import '../converters/converter.dart';
import '../validators/validator.dart';

class Replacer2 {
  final String key;
  final int type;

  final dynamic result;
  final List<dynamic> results;
  final Map<String, dynamic> resultMap;

  final int position;

  const Replacer2({
    required this.key,
    required this.type,
    this.result,
    this.results = const [],
    this.resultMap = const {},
    this.position = 0,
  });

  String getKey() {
    return key;
  }

  int getType() {
    return type;
  }

  int getPosition() {
    return position;
  }

  T? getResult<T>(T cls) {
    if (result.runtimeType == cls.runtimeType) {
      return result as T;
    } else {
      return null;
    }
  }

  T? getResultAt<T>(T cls, int position) {
    final list = getResults(cls);
    if (Validator.isValidList(list) && position < list.length) {
      return list[position];
    } else {
      return null;
    }
  }

  T? getResultByKey<T>(T cls, String key) {
    dynamic data = resultMap[key];
    if (data != null && data.runtimeType == cls.runtimeType) {
      return data as T;
    } else {
      return null;
    }
  }

  List<T> getResults<T>(T cls) {
    if (result.runtimeType == cls.runtimeType) {
      return Converter.toList(cls, results);
    } else {
      return [];
    }
  }
}
