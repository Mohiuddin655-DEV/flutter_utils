import 'package:flutter/material.dart';

import 'text_view_with_app_size_config.dart';
import 'text_view_without_app_size_config.dart';

class SizeConfigBody extends StatelessWidget {
  const SizeConfigBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
