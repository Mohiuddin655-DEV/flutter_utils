import 'package:flutter/material.dart';

import 'bottom_navigation_body.dart';
import 'bottom_navigation_button.dart';
import 'bottom_navigation_buttons.dart';
class BottomNavigationView extends StatefulWidget {
  final Widget? body;
  final List<BottomNavigationButton> buttons;
  final Function(BuildContext context, int index) builder;

  const BottomNavigationView({
    super.key,
    this.body,
    required this.buttons,
    required this.builder,
  });

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          BottomNavigationBody(
            index: _index,
            child: widget.body,
          ),
          BottomNavigationButtons(
            index: _index,
            children: widget.buttons,
            onChanged: (value) {
              setState(() {
                _index = value;
                widget.builder.call(context, value);
              });
            },
          )
        ],
      ),
    );
  }
}
