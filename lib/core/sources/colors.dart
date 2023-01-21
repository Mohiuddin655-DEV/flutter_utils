import 'package:flutter/material.dart';

import '../utils/configurations/color_config.dart';
import 'data/color_codes.dart';

class AppColors {
  const AppColors._();

  static ColorConfig buttonTextColor = ColorConfig.of(
    primary: Colors.white,
    secondary: ColorCodes.greenHolo,
  );
  static ColorConfig buttonBackgroundColor = ColorConfig.of(
    primary: ColorCodes.green,
    secondary: ColorCodes.greenLight,
  );
}
