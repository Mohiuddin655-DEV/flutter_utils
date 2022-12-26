import 'package:flutter/material.dart';

class ScreenProvider<T> {
  void load({
    required BuildContext context,
    required OnScreenProviderListener<T> listener,
    required List<ScreenValue<T>> values,
  }) {
    if (values.isNotEmpty) {
      for (int index = 0; index < values.length; index++) {
        final ScreenValue<T> value = values[index];

        final event = Event<T>(context, value);

        if (value.valid) {
          if (listener.onSkip(event)) break;
        } else {
          if (listener.onHold(event)) break;
        }

        if (values.length == index + 1) listener.onDefault(context);
      }
    }
  }
}

abstract class OnScreenProviderListener<T> {
  void onDefault(BuildContext context) {}

  bool onSkip(Event<T> event) => false;

  bool onHold(Event<T> event);
}

class Event<T> {
  final BuildContext context;
  late T? mScreen;

  Event(this.context, ScreenValue<T> result) {
    mScreen = result.screen;
  }
}

class ScreenValue<T> {
  final bool valid;
  final T? screen;

  const ScreenValue(this.valid, this.screen);
}
