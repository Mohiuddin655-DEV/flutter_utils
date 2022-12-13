import 'package:flutter/material.dart';

class BottomNavigationCounter extends StatelessWidget {
  final Color primary;
  final bool isSelected;
  final int counter;

  const BottomNavigationCounter({
    Key? key,
    this.primary = Colors.black,
    this.isSelected = false,
    this.counter = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = counter < 100 && counter >= 0 ? '$counter' : "99";
    final visible = counter > 0;
    final color = visible
        ? isSelected
        ? primary
        : Colors.white
        : Colors.transparent;
    final background = visible
        ? isSelected
        ? Colors.white
        : primary
        : Colors.transparent;

    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          ),
        ),
      ),
    );
  }
}