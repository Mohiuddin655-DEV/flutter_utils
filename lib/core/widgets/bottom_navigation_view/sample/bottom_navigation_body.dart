import 'package:flutter/material.dart';

class BottomNavigationBody extends StatelessWidget {
  final int index;
  final Widget? child;

  const BottomNavigationBody({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: child ?? Center(child: Text('Selected Page: $index')),
    );
  }
}
