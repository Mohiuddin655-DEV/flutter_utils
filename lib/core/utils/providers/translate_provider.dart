import '../api/translate_api.dart';

class TranslateProvider {
  static Future<String> translate(
    String language,
    String? text,
  ) async {
    if (text != null && text.isNotEmpty) {
      final response = await TranslateApi.of()
          .setDefaultLang('en')
          .setTranslateLang(language)
          .setTranslateText(text)
          .execute();

      return response.getResult() ?? '';
    } else {
      return '';
    }
  }
}
