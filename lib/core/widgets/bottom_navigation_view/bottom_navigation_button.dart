import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/bottom_navigation_view/bottom_navigation_counter.dart';

class BottomNavigationButton extends StatefulWidget {
  final Color primary, secondary;
  final bool isSelected;
  final Function() onPressed;
  final Widget icon;
  final int counter;
  final double padding;

  const BottomNavigationButton({
    Key? key,
    required this.onPressed,
    required this.isSelected,
    required this.icon,
    this.counter = 0,
    required this.primary,
    required this.secondary,
    this.padding = 8,
  }) : super(key: key);

  @override
  State<BottomNavigationButton> createState() => _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<BottomNavigationButton> {
  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(widget.padding);
    final primary = widget.primary;
    final counter = widget.counter;
    final isSelected = widget.isSelected;
    return GestureDetector(
      onTap: widget.onPressed,
      child: AbsorbPointer(
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 7, right: 7),
                child: AnimatedContainer(
                  height: 40,
                  width: 40,
                  padding: padding,
                  color: primary,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 500),
                  child: widget.icon,
                ),
              ),
              BottomNavigationCounter(
                primary: primary,
                isSelected: isSelected,
                counter: counter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
