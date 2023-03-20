import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/controllers/view_controller.dart';
import 'package:flutter_utils/core/widgets/view.dart';

typedef OnChangeIndex = Function(int index);

class BottomNavigationView extends View {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class BottomNavigationController extends ViewController {
  int index = 0;

  void setIndex(int value) {
    index = value;
    notify;
  }
}
