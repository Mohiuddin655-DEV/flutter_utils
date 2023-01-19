import 'package:flutter/material.dart';

import '../utils/configurations/color_config.dart';
import 'data/color_codes.dart';

class AppColors {
  const AppColors._();

  static ColorConfig buttonTextColor = ColorConfig.of(
    primary: Colors.white,
    secondary: Colors.grey.shade600,
  );
  static ColorConfig buttonBackgroundColor = ColorConfig.of(
    primary: ColorCodes.red,
    secondary: ColorCodes.redLight,
  );
}
