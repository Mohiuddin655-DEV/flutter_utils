import 'package:flutter/material.dart';
import 'package:flutter_utils/presentation/pages/responsive/responsive_page.dart';
import 'package:flutter_utils/sample.dart';

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
      home: const Simple(),
    );
  }
}
