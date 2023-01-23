import 'package:flutter/material.dart';

import '../utils/configurations/icon_config.dart';
import 'data/color_codes.dart';

class AppIcons {
  const AppIcons._();

  static IconConfig home = IconConfig.of(
    primary: "assets/png_icons/icon_double_tick.png",
    secondary: Icons.add,
  );

  static IconConfig notification = IconConfig.of(
    primary: ColorCodes.green,
    secondary: ColorCodes.greenLight,
  );
}
