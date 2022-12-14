
import 'package:flutter/material.dart';

class BottomNavigationInnerItem extends StatefulWidget {
  const BottomNavigationInnerItem({
    Key? key,
    required this.onPressed,
    required this.isSelected,
    required this.imagePath,
    this.counter = 0,
  }) : super(key: key);

  final bool isSelected;
  final Function() onPressed;
  final String imagePath;
  final int counter;

  @override
  State<BottomNavigationInnerItem> createState() =>
      _BottomNavigationInnerItemState();
}

class _BottomNavigationInnerItemState extends State<BottomNavigationInnerItem> {
  //late final _imageWidget = Image.asset(widget.imagePath);
  late final icon = const Icon(Icons.home);

  @override
  void didChangeDependencies() {
    //precacheImage(_imageWidget.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AbsorbPointer(
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 7, right: 7),
                child: AnimatedContainer(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.isSelected ? Colors.blue : Colors.white,
                  ),
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 500),
                  child: icon,
                ),
              ),
              NavButtonCounter(
                primary: Colors.blue,
                isSelected: widget.isSelected,
                counter: widget.counter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButtonCounter extends StatelessWidget {
  final Color primary;
  final bool isSelected;
  final int counter;

  const NavButtonCounter({
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
