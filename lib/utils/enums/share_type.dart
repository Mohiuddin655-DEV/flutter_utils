enum ShareType {
  any("*/*"),
  email("message/rfc822"),
  html("text/html"),
  json("text/json"),
  sms("vnd.android-dir/mms-sms"),
  text("text/plain"),
  image("image/*"),
  imageJPG("image/jpg"),
  imagePNG("image/png"),
  imageGIF("image/gif"),
  video("video/*"),
  video3GP("video/3gp"),
  videoMP4("video/mp4");

  final String value;

  const ShareType(this.value);
}
