import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/responsive_body.dart';

class Body extends StatelessWidget {
  final int flex;
  final String title;
  final Color color;

  const Body({
    Key? key,
    this.flex = 1,
    required this.title,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBody(
      flex: flex,
      background: color,
      builder: (context, config) {
        print(config.size);
        return Center(
          child: Container(
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
        );
      },
    );
  }
}
