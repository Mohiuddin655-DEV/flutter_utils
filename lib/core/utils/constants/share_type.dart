import '../annotations/string_def.dart';

@StringDef([
  ShareType.ANY,
  ShareType.EMAIL,
  ShareType.HTML_TEXT,
  ShareType.IMAGE,
  ShareType.JSON,
  ShareType.SMS,
  ShareType.PLAIN_TEXT,
  ShareType.VIDEO
])
class ShareType {
  static const String ANY = "*/*";
  static const String EMAIL = "message/rfc822";
  static const String HTML_TEXT = "text/html";
  static const String JSON = "text/json";
  static const String SMS = "vnd.android-dir/mms-sms";
  static const String PLAIN_TEXT = "text/plain";
  static const String IMAGE = "image/*"; // image/jpg, image/png, image/gif
  static const String VIDEO = "video/mp4"; // video/mp4, video/3gp
}
