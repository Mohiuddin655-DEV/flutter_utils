import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TextViewWithAppSizeConfig(),
            SizedBox(height: 40),
            TextViewWithoutAppSizeConfig(),
          ],
        ),
      ),
    );
  }
}

class TextViewWithAppSizeConfig extends StatelessWidget {
  const TextViewWithAppSizeConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig config = SizeConfig.of(context);
    double fontSize = config.fontSize(24.00);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: config.space(40),
        vertical: config.space(24),
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(config.pixel(24)),
      ),
      child: Text(
        'Font Size : ${fontSize.toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: config.fontSize(24),
        ),
      ),
    );
  }
}

class TextViewWithoutAppSizeConfig extends StatelessWidget {
  const TextViewWithoutAppSizeConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = 24.00;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        'Font Size : ${fontSize.toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
