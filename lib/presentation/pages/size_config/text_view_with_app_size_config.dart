import 'package:flutter/material.dart';

import '../../../core/utils/configurations/size_config.dart';

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
