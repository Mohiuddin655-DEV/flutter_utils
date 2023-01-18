import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color red = ColorConfig(
    ColorCodes.red,
    ColorCodes.redLight,
    ColorCodes.redHolo,
  );
}

class ColorConfig extends Color {
  final int? secondaryValue, ternaryValue;

  const ColorConfig(
    super.value, [
    this.secondaryValue,
    this.ternaryValue,
  ]);

  Color get secondary => Color(secondaryValue ?? value);

  Color get ternary => Color(ternaryValue ?? value);

  Color get enabled => this;

  Color get disabled => secondary;

  Color get selected => this;

  Color get unselected => ternary;
}

class ColorCodes {
  static const int light = 0xFFFAFAFA;
  static const int lightHolo = 0xFFF2F2F2;
  static const int lightDark = 0xFFEAEAEA;

  static const int green = 0xFF2ECA7F;
  static const int greenLight = 0xFFE6FAF0;
  static const int greenLight2 = 0xFFCFF4E2;
  static const int greenHolo = 0xFF8CE4BA;
  static const int greenDark = 0xFF25A165;
  static const int greenDeep = 0xFF05140D;

  static const int blue = 0xFF19A4FA;
  static const int blueLight = 0xFFE8F6FE;
  static const int blueHolo = 0xFF8BD1FC;
  static const int blueDark = 0xFF1D89E4;
  static const int blueDeep = 0xFF021019;

  static const int grey = 0xFF808080;
  static const int greyLight = 0xFF999999;
  static const int greyHolo = 0xFF8C8C8C;
  static const int greyDark = 0xFF737373;
  static const int greyDeep = 0xFF666666;

  static const int yellow = 0xFFFFC107;
  static const int yellowLight = 0xFFFFF9E6;
  static const int yellowHolo = 0xFFFFE083;
  static const int yellowDark = 0xFFE6AE07;
  static const int yellowDeep = 0xFF332702;

  static const int red = 0xFFF44336;
  static const int redLight = 0xFFFEEBEA;
  static const int redHolo = 0xFFFA9F98;
  static const int redDark = 0xFFDC3C30;
  static const int redDeep = 0xFF310D0B;
}
