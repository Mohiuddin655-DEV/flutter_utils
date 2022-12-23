import '../annotations/string_def.dart';

@StringDef([
  SearchType.NONE,
  SearchType.AUDIO,
  SearchType.PHOTO,
  SearchType.POST,
  SearchType.USER,
  SearchType.VIDEO,
  SearchType.WALLPAPER
])
class SearchType {
  static const String NONE = "none";
  static const String AUDIO = "audio";
  static const String PHOTO = "photo";
  static const String POST = "post";
  static const String USER = "user";
  static const String VIDEO = "video";
  static const String WALLPAPER = "wallpaper";
}