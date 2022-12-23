import '../annotations/string_def.dart';

@StringDef([
  DataSourceType.EMAIL,
  DataSourceType.HTML_TEXT,
  DataSourceType.MULTIPLE_EMAIL,
  DataSourceType.MULTIPLE_PHOTO,
  DataSourceType.MULTIPLE_VIDEO,
  DataSourceType.SINGLE_PHOTO,
  DataSourceType.SINGLE_VIDEO,
  DataSourceType.PLAIN_TEXT,
  DataSourceType.TEXT_WITH_PHOTO,
  DataSourceType.TEXT_WITH_VIDEO,
])
class DataSourceType {
  static const String EMAIL = "email";
  static const String HTML_TEXT = "html";
  static const String MULTIPLE_EMAIL = "multiple_email";
  static const String MULTIPLE_PHOTO = "multiple_photo";
  static const String MULTIPLE_VIDEO = "multiple_video";
  static const String SINGLE_PHOTO = "single_photo";
  static const String SINGLE_VIDEO = "single_video";
  static const String PLAIN_TEXT = "text";
  static const String TEXT_WITH_PHOTO = "text_with_photo";
  static const String TEXT_WITH_VIDEO = "text_with_video";
}
