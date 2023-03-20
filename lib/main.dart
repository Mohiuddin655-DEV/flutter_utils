import 'package:flutter/material.dart';
import 'package:flutter_utils/presentation/pages/tab_view_page.dart';

void main() => runApp(const Application());

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Utils',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabViewPage(),
    );
  }
}
