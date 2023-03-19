import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/activity.dart';
import 'package:flutter_utils/core/widgets/view.dart';
import 'package:flutter_utils/ui/phone_auth/body.dart';

import '../../core/unverified_widgets/password_field.dart';
import '../../core/unverified_widgets/phone_field.dart';
import '../../core/widgets/button.dart';

class AuthPhoneActivity extends Activity {
  AuthPhoneActivity({super.key});

  final ButtonController button = ButtonController();
  final PhoneEditingController phone = PhoneEditingController();
  final PasswordEditTextController password = PasswordEditTextController();

  @override
  View onCreate(BuildContext context) {
    return Screen(
      button: button,
      phone: phone,
      password: password,
    );
  }

  @override
  void onListener() {
    phone.setTextChangeListener((value) {
      checkValidity;
    });
    password.setOnChangeListener(() {
      checkValidity;
    });
  }

  void get checkValidity {
    final a = phone.isValid;
    final b = password.isValid;
    button.setEnabled(a && b);
  }
}
