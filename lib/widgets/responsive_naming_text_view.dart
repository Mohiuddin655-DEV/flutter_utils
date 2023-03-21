import 'package:flutter/material.dart';

class ResponsiveNamingTextView extends StatelessWidget {
  final String name, value;
  final Color nameColor, valueColor;
  final double nameSize, valueSize;

  const ResponsiveNamingTextView({
    Key? key,
    required this.name,
    required this.value,
    this.nameColor = Colors.black,
    this.valueColor = Colors.black,
    this.nameSize = 16,
    this.valueSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final nameX = size.width * 0.25;
    final separatorX = size.width * 0.05;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: nameX,
            child: Text(
              name,
              style: TextStyle(
                color: nameColor,
                fontSize: nameSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: separatorX,
            child: Text(
              ':',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: valueColor,
                fontSize: valueSize,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: valueSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
