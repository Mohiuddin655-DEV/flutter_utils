import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/bottom_navigation_view/bottom_navigation_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Utils',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigationView(
        onChanged: (context, index) {
          print(index);
        },
      ),
    );
  }
}
