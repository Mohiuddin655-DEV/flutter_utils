class DefaultFormat {
  const DefaultFormat._();

  static const String DAY_FULL_NAME = "EEEE";
  static const String DAY_SHORT_NAME = "EE";
  static const String DAY = "dd";
  static const String MONTH_FULL_NAME = "MMMM";
  static const String MONTH_SHORT_NAME = "MMM";
  static const String MONTH = "MM";
  static const String FULL_YEAR = "yyyy";
  static const String SHORT_YEAR = "yy";
  static const String HOUR = "hh";
  static const String MINUTE = "mm";
  static const String SECOND = "ss";
  static const String TIME_ZONE = "TZD";

  static const String TIME_MS = '$MINUTE:$SECOND';
  static const String TIME_HM = '$HOUR:$MINUTE';
  static const String TIME_HMa = '$HOUR:$MINUTE a';
  static const String TIME_HMSa = '$HOUR:$MINUTE:$SECOND a';
  static const String TIME_HMS_ZONE = '$HOUR:$MINUTE:$SECOND $TIME_ZONE';

  static const String DATE_YMD = '$FULL_YEAR-$MONTH-$DAY';
  static const String DATE_DMY = '$DAY-$MONTH-$FULL_YEAR';
  static const String DATE_DM_Y = '$DAY $MONTH_FULL_NAME, $FULL_YEAR';
  static const String DATE_MD_Y = '$MONTH_FULL_NAME $DAY, $FULL_YEAR';
  static const String DATE_E_DM_Y =
      '$DAY_FULL_NAME, $DAY $MONTH_FULL_NAME, $FULL_YEAR';
  static const String DATE_E_MD_Y =
      '$DAY_FULL_NAME, $MONTH_FULL_NAME $DAY, $FULL_YEAR';
}
