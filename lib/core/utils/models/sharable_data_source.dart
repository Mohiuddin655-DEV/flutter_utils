import '../enums/share_type.dart';

class SharableDataSource {
  ShareType _type;

  String? _chooserTitle;
  String? _subject;
  String? _text;
  List<String> _paths = [];
  List<String>? _mimeTypes;

  SharableDataSource([this._type = ShareType.text]);

  SharableDataSource setType(ShareType type) {
    _type = type;
    return this;
  }

  SharableDataSource setChooserTitle(String chooserTitle) {
    _chooserTitle = chooserTitle;
    return this;
  }

  SharableDataSource setSubject(String subject) {
    _subject = subject;
    return this;
  }

  SharableDataSource setText(String text) {
    _text = text;
    return this;
  }

  SharableDataSource setPath(String path) {
    _paths.insert(0, path);
    return this;
  }

  SharableDataSource setPaths(List<String> paths) {
    _paths = paths;
    return this;
  }

  SharableDataSource setMimeTypes(List<String> mimeTypes) {
    _mimeTypes = mimeTypes;
    return this;
  }

  ShareType get type => _type;

  String get chooserTitle => _chooserTitle ?? "Share to...";

  String? get subject => _subject;

  String? get text => _text;

  String? get path => paths.isNotEmpty ? paths[0] : null;

  List<String> get paths => _paths;

  List<String>? get mimeTypes => _mimeTypes;
}
