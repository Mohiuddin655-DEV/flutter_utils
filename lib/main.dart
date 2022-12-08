import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/device.dart';
import 'package:flutter_utils/core/utils/device_config.dart';
import 'package:flutter_utils/core/widgets/responsive_layout.dart';
import 'package:flutter_utils/presentation/pages/responsive/mobile_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Utils',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Utils'),
      ),
      body: ResponsiveLayout(
        config: const ScreenConfig(
          mobile: Device(x: 1, y: 1.5),
          tab: Device(x: 1, y: 1),
          laptop: Device(x: 1.5, y: 1),
          desktop: Device(x: 2.5, y: 1),
        ),
        mobileBody: Body(
          title: 'Mobile Body',
          color: Colors.deepOrange.shade300,
        ),
        tabBody: Body(
          title: 'Tab Body',
          color: Colors.deepPurple.shade300,
        ),
        laptopBody: Body(
          title: 'Laptop Body',
          color: Colors.blue.shade300,
        ),
        desktopBody: Body(
          title: 'Desktop Body',
          color: Colors.deepPurple.shade300,
        ),
        tvBody: Body(
          title: 'TV Body',
          color: Colors.green.shade300,
        ),
      ),
    );
  }
}
