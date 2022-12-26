import 'package:flutter/material.dart';

class DialogHelper {
  final BuildContext context;

  const DialogHelper(this.context);
}

abstract class OnDataChangeListener<T> {
  void onChange(T t);
}
