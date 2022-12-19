import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/bottom_navigation_view/bottom_navigation_button.dart';
import 'package:flutter_utils/core/widgets/bottom_navigation_view/bottom_navigation_view.dart';
import 'package:flutter_utils/presentation/pages/size_config/size_config_body.dart';

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
      home: SizeConfigBody(),
    );
  }
}
