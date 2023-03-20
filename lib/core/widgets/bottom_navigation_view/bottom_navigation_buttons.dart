import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/bottom_navigation_view/bottom_navigation_button.dart';

class BottomNavigationButtons extends StatefulWidget {
  const BottomNavigationButtons({
    Key? key,
    required this.index,
    required this.onChanged,
    required this.children,
  }) : super(key: key);

  final int index;
  final Function(int) onChanged;
  final List<BottomNavigationButton> children;

  @override
  State<BottomNavigationButtons> createState() =>
      _BottomNavigationButtonsState();
}

class _BottomNavigationButtonsState extends State<BottomNavigationButtons> {
  late var _index = widget.index;

  void _changePosition({required int index}) {
    if (_index != index) {
      setState(() {
        _index = index;
        widget.onChanged(_index);
      });
    }
  }

  @override
  void didUpdateWidget(covariant BottomNavigationButtons old) {
    if (widget.index != old.index) {
      _index = widget.index;
    }
    super.didUpdateWidget(old);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.children,
      ),
    );
  }
}
