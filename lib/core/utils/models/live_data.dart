import 'package:flutter/material.dart';

class LiveData<T> extends ValueNotifier<T> {
  LiveData(super.value);

  void setValue(T value) {
    this.value = value;
    notifyListeners();
  }

  T getValue() => value;
}
