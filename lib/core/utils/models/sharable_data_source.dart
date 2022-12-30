import '../enums/share_type.dart';

class SharableDataSource {
  ShareType _type;

  String? _chooserTitle;
  String? _subject;
  String? _text;
  String? _htmlText;
  String? _uid;
  Uri? _stream;
  List<Uri>? _streams;
  List<String>? _toAddresses;
  List<String>? _bccAddresses;
  List<String>? _ccAddresses;

  SharableDataSource([this._type = ShareType.text]);

  ShareType get type => _type;

  SharableDataSource setType(ShareType type) {
    _type = type;
    return this;
  }

  String get chooserTitle => _chooserTitle ?? "Share to...";

  SharableDataSource setChooserTitle(String chooserTitle) {
    _chooserTitle = chooserTitle;
    return this;
  }

  String? get subject => _subject;

  SharableDataSource setSubject(String subject) {
    _subject = subject;
    return this;
  }

  String? get text => _text;

  SharableDataSource setText(String text) {
    _text = text;
    return this;
  }

  String? get htmlText => _htmlText;

  SharableDataSource setHtmlText(String htmlText) {
    _htmlText = htmlText;
    return this;
  }

  String? get uid => _uid;

  SharableDataSource setUid(String uid) {
    _uid = uid;
    return this;
  }

  Uri? get stream => _stream;

  SharableDataSource setStream(Uri stream) {
    _stream = stream;
    return this;
  }

  List<Uri>? get streams => _streams;

  SharableDataSource setStreams(List<Uri> streams) {
    _streams = streams;
    return this;
  }

  List<String>? get toAddresses => _toAddresses;

  SharableDataSource setToAddresses(List<String> toAddresses) {
    _toAddresses = toAddresses;
    return this;
  }

  List<String>? get bccAddresses => _bccAddresses;

  SharableDataSource setBccAddresses(List<String> bccAddresses) {
    _bccAddresses = bccAddresses;
    return this;
  }

  List<String>? get ccAddresses => _ccAddresses;

  SharableDataSource setCcAddresses(List<String> ccAddresses) {
    _ccAddresses = ccAddresses;
    return this;
  }
}
