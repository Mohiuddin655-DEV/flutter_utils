import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/view.dart';

import '../../core/unverified_widgets/password_field.dart';
import '../../core/unverified_widgets/phone_field.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/text_view.dart';

class Screen extends View {
  final ButtonController button;
  final PhoneEditingController phone;
  final PasswordEditTextController password;

  const Screen({
    super.key,
    required this.button,
    required this.phone,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextView(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            text: "Verify your \nphone number",
            textAlign: TextAlign.center,
            textColor: Colors.black,
            textStyle: FontWeight.bold,
            textSize: 24,
          ),
          const TextView(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            text:
            "We have sent you an SMS with a code to \nnumber +84 905070017",
            textAlign: TextAlign.center,
            textColor: Colors.grey,
            textSize: 14,
          ),
          PhoneField(
            controller: phone,
            margin: const EdgeInsets.symmetric(vertical: 24),
            hintCode: "+880",
            hintNumber: "Enter phone number",
            validator: (value) {
              return value.numberWithCode.length > 5;
            },
          ),
          PasswordField(
            controller: password,
            hint: "Enter your password",
            validator: (value) {
              return value.length > 10;
            },
          ),
          Button(
            controller: button,
            width: 200,
            text: "Login",
            borderRadius: 12,
          ),
        ],
      ),
    );
  }
}
