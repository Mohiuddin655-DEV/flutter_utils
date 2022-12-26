enum ShareType {
  ANY("*/*"),
  EMAIL("message/rfc822"),
  HTML_TEXT("text/html"),
  JSON("text/json"),
  SMS("vnd.android-dir/mms-sms"),
  PLAIN_TEXT("text/plain"),
  IMAGE("image/*"), // image/jpg, image/png, image/gif
  VIDEO("video/mp4"); // video/mp4, video/3gp

  final String value;

  const ShareType(this.value);
}
