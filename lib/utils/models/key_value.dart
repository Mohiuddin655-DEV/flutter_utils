import 'dart:typed_data';

import '../enums/data_type.dart';

class KeyValue {
  final String mKey;
  final dynamic mValue;
  late DataType mType;

  KeyValue(
    this.mKey,
    this.mValue,
  );

  String get key => mKey;

  T? value<T>() => mValue is T ? mValue : null;

  DataType get type {
    if (mValue is bool) {
      return DataType.BOOLEAN;
    } else if (mValue is Uint8List) {
      return DataType.BYTE;
    } else if (mValue is double) {
      return DataType.DOUBLE;
    } else if (mValue is int) {
      return DataType.INTEGER;
    } else if (mValue is String) {
      return DataType.STRING;
    } else if (mValue is List) {
      return DataType.ARRAY_LIST;
    } else {
      return DataType.SERIALIZABLE;
    }
  }
}
