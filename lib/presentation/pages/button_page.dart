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
              text: "Submit",
              textAllCaps: true,
              colorState: (state) => AppColors.buttonTextColor
                  .detect(state == ButtonState.disabled),
              backgroundState: (state) => AppColors.buttonBackgroundColor
                  .detect(state == ButtonState.disabled),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
