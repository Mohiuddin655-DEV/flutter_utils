
import 'package:flutter/material.dart';

import 'bottom_navigation_inner_widget.dart';

class DashBoardBottomNavigation extends StatefulWidget {
  const DashBoardBottomNavigation({
    Key? key,
    required this.onChangeIndex,
    required this.selectedIndex,
  }) : super(key: key);

  final Function(int) onChangeIndex;
  final int selectedIndex;

  @override
  State<DashBoardBottomNavigation> createState() =>
      _DashBoardBottomNavigationState();
}

class _DashBoardBottomNavigationState extends State<DashBoardBottomNavigation> {
  late var _selectedIndex = widget.selectedIndex;

  void _workAccordingToIndex({required int index}) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        widget.onChangeIndex(_selectedIndex);
      });
    }
  }

  @override
  void didUpdateWidget(covariant DashBoardBottomNavigation oldWidget) {
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavigationInnerItem(
            imagePath: 'assets/png/home.png',
            onPressed: () {
              _workAccordingToIndex(index: 0);
            },
            isSelected: _selectedIndex == 0,
          ),
          BottomNavigationInnerItem(
            imagePath: 'assets/png/play.png',
            onPressed: () {
              _workAccordingToIndex(index: 1);
            },
            isSelected: _selectedIndex == 1,
          ),
          BottomNavigationInnerItem(
            imagePath: 'assets/png/ic_receipt_regular.png',
            onPressed: () {
              _workAccordingToIndex(index: 2);
            },
            isSelected: _selectedIndex == 2,
          ),
          BottomNavigationInnerItem(
            imagePath: 'assets/png/user.png',
            onPressed: () {
              _workAccordingToIndex(index: 3);
            },
            isSelected: _selectedIndex == 3,
          ),
        ],
      ),
    );
  }
}
