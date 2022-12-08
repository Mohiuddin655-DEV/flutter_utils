import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';

class Body extends StatelessWidget {
  final String title;
  final Color color;
  final double width, height;

  const Body({
    Key? key,
    required this.title,
    this.color = Colors.white,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Container(
          width: width,
          height: height,
          color: Colors.black.withOpacity(0.25),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: config.space(40),
                vertical: config.space(24),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(config.pixel(24)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: config.fontSize(24),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
