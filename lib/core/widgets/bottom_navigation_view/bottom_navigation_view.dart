import 'package:flutter/material.dart';

import 'sample/a.dart';
import 'sample/dashboard_bottom_navigation.dart';

class BottomNavigationView extends StatefulWidget {
  final Function(BuildContext context, int index) onChanged;

  const BottomNavigationView({super.key, required this.onChanged});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var _selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          DashBoardSelectionWidget(selectedId: _selectedId),
          DashBoardBottomNavigation(
            selectedIndex: _selectedId,
            onChangeIndex: (value) {
              setState(() {
                _selectedId = value;
                widget.onChanged.call(context, value);
              });
            },
          )
        ],
      ),
    );
  }
}
