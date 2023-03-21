import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../enums/data_type.dart';
import '../helpers/preference_helper.dart';
import '../models/key_value.dart';

class DataPreferenceLoader {
  static const String _tag = 'data_preference_loader';

  static void setPreference({
    required SharedPreferences preferences,
    required String key,
    bool value = true,
  }) {
    PreferenceHelper(preferences).setBoolean(
      key: key,
      value: value,
    );
  }

  static void load({
    required SharedPreferences preferences,
    required OnDataPreferenceLoaderListener listener,
    required List<KeyValue> keyValues,
  }) {
    if (keyValues.isNotEmpty) {
      final helper = PreferenceHelper(preferences);

      for (int index = 0; index < keyValues.length; index++) {
        final keyValue = keyValues[index];

        final event = Event(helper, keyValue);

        if (_isExisted(helper, keyValue)) {
          if (listener.onExisted(event)) break;
        } else {
          if (listener.onUnExisted(event)) break;
        }

        if (keyValues.length == index + 1) listener.onDefault(helper);
      }
    }
  }

  static bool _isExisted(PreferenceHelper helper, KeyValue keyValue) {
    final String key = keyValue.mKey;

    try {
      switch (keyValue.mType) {
        case DataType.BOOLEAN:
          return helper.getBoolean(key: key);
        case DataType.INTEGER:
          return helper.getInt(key: key) != 0;
        case DataType.STRING:
          return helper.getString(key: key) != null;
        default:
          return false;
      }
    } on Exception catch (e) {
      log("isExisted: $e", name: _tag, error: e);
      return false;
    }
  }
}

abstract class OnDataPreferenceLoaderListener {
  void onDefault(PreferenceHelper helper) {}

  bool onExisted(Event event) => false;

  bool onUnExisted(Event event);
}

class Event {
  final PreferenceHelper helper;
  late String mKey;
  late DataType mType;
  late dynamic mValue;

  Event(this.helper, KeyValue result) {
    mKey = result.mKey;
    mType = result.mType;
    mValue = result.mValue;
  }
}
