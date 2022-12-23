enum ByteQuality {
  NONE;

  static const double _MEGA_BYTE = 1024 * 1024;

  static const double PHOTO_STANDARD_QUALITY = _MEGA_BYTE;
  static const double PHOTO_HIGH_QUALITY = _MEGA_BYTE * 2;
  static const double PHOTO_MEDIUM_QUALITY = _MEGA_BYTE / 2;
  static const double PHOTO_LOW_QUALITY = _MEGA_BYTE / 4;
}
