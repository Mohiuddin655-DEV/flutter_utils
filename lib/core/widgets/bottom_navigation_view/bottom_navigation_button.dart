import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/bottom_navigation_view/bottom_navigation_counter.dart';

class BottomNavigationButton extends StatefulWidget {
  final Color primary, secondary;
  final bool isSelected;
  final Function() onPressed;
  final String imagePath;
  final int counter;
  final double padding;

  const BottomNavigationButton({
    Key? key,
    required this.onPressed,
    required this.isSelected,
    required this.imagePath,
    this.counter = 0,
    required this.primary,
    required this.secondary,
    required this.padding,
  }) : super(key: key);

  @override
  State<BottomNavigationButton> createState() =>
      _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<BottomNavigationButton> {
  late final _imageWidget = Image.asset(widget.imagePath);

  @override
  void didChangeDependencies() {
    precacheImage(_imageWidget.image, context);
    super.didChangeDependencies();
  }

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
                  child: _imageWidget,
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
