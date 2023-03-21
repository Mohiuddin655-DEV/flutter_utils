import 'dart:convert';

import 'package:http/http.dart' as http;

import '../enums/code.dart';
import '../responses/response.dart';

class TranslateApi {
  String _defaultLang = "en";
  String? _translateLang;
  String? _text;

  TranslateApi._();

  static TranslateApi? _instance;

  static TranslateApi get instance => _instance ??= TranslateApi._();

  static TranslateApi of({
    String? defaultLang,
    String? translateLang,
    String? text,
  }) {
    instance._defaultLang = defaultLang ?? instance._defaultLang;
    instance._translateLang = translateLang ?? instance._translateLang;
    instance._text = text ?? instance._text;
    return instance;
  }

  TranslateApi withDefaultLang(String defaultLang) {
    _defaultLang = defaultLang;
    return this;
  }

  TranslateApi withTranslateLang(String translateLang) {
    _translateLang = translateLang;
    return this;
  }

  TranslateApi withTranslateText(String text) {
    _text = text;
    return this;
  }

  Future<Response<String>> get execute async {
    final response = Response<String>(Code.translate.value);
    if (_defaultLang.isNotEmpty &&
        _translateLang != null &&
        _translateLang!.isNotEmpty &&
        _text!.isNotEmpty) {
      try {
        // String url = "https://translate.google.com/?sl=en&tl=bn&text=hi&op=translate"
        // String url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=bn&dt=t&q=%nice";
        String encode = Uri.encodeComponent(_text ?? '');
        final url =
            "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$_defaultLang&tl=$_translateLang&dt=t&q=$encode";
        final uri = Uri.parse(url);
        final data = await http.get(uri);
        if (data.statusCode == 200) {
          final text = jsonDecode(data.body);
          response.withResult(text);
        } else {
          response.withException(
            exception: 'Error code : ${data.statusCode}',
          );
        }
      } catch (e) {
        response.withException(exception: e.toString());
      }
    }
    return response;
  }
}
