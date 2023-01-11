import 'package:flutter/material.dart';
import 'package:flutter_utils/presentation/pages/image_view_checking_page/image_view_checking_view.dart';

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
      home: const ImageViewPage(),
    );
  }
}
