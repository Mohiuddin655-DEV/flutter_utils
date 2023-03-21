import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/preference_helper.dart';

class BooleanPreferenceLoader<T> {
  static const String _tag = "boolean_preference_loader";

  static void setPreference({
    required SharedPreferences preferences,
    required Type runtimeType,
    bool value = true,
  }) {
    final String key = '$runtimeType';
    PreferenceHelper(preferences).setBoolean(
      key: key,
      value: value,
    );
  }

  void load({
    required SharedPreferences preferences,
    required OnBooleanPreferenceLoaderListener<T> listener,
    required List<T> types,
  }) {
    if (types.isNotEmpty) {
      final helper = PreferenceHelper(preferences);

      for (int index = 0; index < types.length; index++) {
        T type = types[index];

        if (type != null) {
          final event = Event<T>(helper, type, types);

          if (isExisted(helper, type)) {
            if (listener.onExisted(event)) break;
          } else {
            if (listener.onUnExisted(event)) break;
          }

          if (types.length == index + 1) listener.onDefault(helper);
        }
      }
    }
  }

  bool isExisted(PreferenceHelper helper, T t) {
    try {
      return helper.getBoolean(key: t.runtimeType.toString());
    } on Exception catch (e) {
      log("isExisted: $e", name: _tag, error: e);
      return false;
    }
  }
}

abstract class OnBooleanPreferenceLoaderListener<T> {
  void onDefault(PreferenceHelper helper) {}

  bool onExisted(Event<T> event) {
    return false;
  }

  bool onUnExisted(Event<T> event);
}

class Event<T> {
  final PreferenceHelper helper;
  final T result;
  final List<T> types;

  const Event(this.helper, this.result, this.types);
}
