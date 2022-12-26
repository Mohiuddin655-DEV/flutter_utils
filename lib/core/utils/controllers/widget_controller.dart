import 'package:flutter/material.dart';

class Controller {
  late final BuildContext _context;
  late ScrollController _controller;

  Controller(this._context) {
    _controller = ScrollController();
  }

  static Controller of(BuildContext context) {
    return Controller(context);
  }

  void loadScreen(Widget screen) {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => screen));
  }

  void screenBack() {
    Navigator.pop(_context);
  }

  ScrollController paging({required Function() func}) {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          func.call();
        }
      }
    });
    return _controller;
  }
}
