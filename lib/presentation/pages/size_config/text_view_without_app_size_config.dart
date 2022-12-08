import 'package:flutter/material.dart';

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
