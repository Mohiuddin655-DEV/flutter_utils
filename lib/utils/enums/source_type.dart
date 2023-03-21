enum SourceType {
  none(""),
  email("email"),
  html("html"),
  multipleEmail("multiple_email"),
  multiplePhoto("multiple_photo"),
  multipleVideo("multiple_video"),
  singlePhoto("single_photo"),
  singleVideo("single_video"),
  text("text"),
  textWithPhoto("text_with_photo"),
  textWithVideo("text_with_video");

  final String value;

  const SourceType(this.value);
}
