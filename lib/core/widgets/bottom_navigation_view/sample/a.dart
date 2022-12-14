
import 'package:flutter/material.dart';

class DashBoardSelectionWidget extends StatelessWidget {
  const DashBoardSelectionWidget({super.key, required this.selectedId});

  final int selectedId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: getWidgetById(selectedId),
    );
  }
}

Widget getWidgetById(int id){
  switch(id){
    default: return Center(child: Text('Selected Page: $id'));
  }
}
