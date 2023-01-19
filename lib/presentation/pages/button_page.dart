import 'package:flutter/material.dart';

import '../../core/sources/colors.dart';
import '../../core/widgets/button.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              textColor: AppColors.buttonTextColor,
              background: AppColors.buttonBackgroundColor,
              text: "Submit",
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              //onClick: () {},
              textAllCaps: true,
            ),
          ],
        ),
      ),
    );
  }
}
