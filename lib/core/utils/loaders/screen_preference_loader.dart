import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../enums/data_type.dart';
import '../helpers/preference_helper.dart';
import '../models/value.dart';

class ScreenPreferenceLoader<T> {
  static const String _tag = "screen_preference_loader";

  static void setPreference({
    required SharedPreferences preferences,
    required String mScreenName,
    dynamic value,
  }) {
    final helper = PreferenceHelper(preferences);

    if (value is bool) {
      helper.setBoolean(key: mScreenName, value: value);
    } else if (value is int) {
      helper.setInt(key: mScreenName, value: value);
    } else if (value is String) {
      helper.setString(key: mScreenName, value: value);
    }
  }

  static dynamic getPreference({
    required SharedPreferences preferences,
    required String screen,
    required DataType type,
  }) {
    final helper = PreferenceHelper(preferences);

    switch (type) {
      case DataType.BOOLEAN:
        return helper.getBoolean(key: screen);
      case DataType.INTEGER:
        return helper.getInt(key: screen);
      case DataType.STRING:
        return helper.getString(key: screen);
      default:
        return null;
    }
  }

  static bool isExisted(SharedPreferences preferences, String screen) {
    return PreferenceHelper(preferences).getBoolean(key: screen);
  }

  bool _isExisted(PreferenceHelper helper, Value<T> value) {
    final key = value.mScreenName;
    final type = value.mDataType;

    try {
      if (type == DataType.BOOLEAN) {
        return helper.getBoolean(key: key);
      } else if (type == DataType.INTEGER) {
        return helper.getInt(key: key) != 0;
      } else if (type == DataType.STRING) {
        return helper.getString(key: key) != null;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log("isExisted: $e", name: _tag, error: e);
      return false;
    }
  }

  void load({
    required SharedPreferences preferences,
    required OnScreenPreferenceListener<T> listener,
    required List<Value<T>> values,
  }) {
    if (values.isNotEmpty) {
      final helper = PreferenceHelper(preferences);

      for (int index = 0; index < values.length; index++) {
        final value = values[index];

        final event = Event<T>(helper, value);

        if (_isExisted(helper, value)) {
          if (listener.onExisted(event)) break;
        } else {
          if (listener.onUnExisted(event)) break;
        }

        if (values.length == index + 1) listener.onDefault(helper);
      }
    }
  }
}

abstract class OnScreenPreferenceListener<T> {
  void onDefault(PreferenceHelper helper) {}

  bool onExisted(Event<T> event) => false;

  bool onUnExisted(Event<T> event);
}

class Event<T> {
  final PreferenceHelper helper;
  late String name;
  late DataType type;
  late T? data;

  Event(this.helper, Value<T> value) {
    name = value.mScreenName;
    type = value.mDataType;
    data = value.mData;
  }
}
