import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/country_info.dart';

class DefaultData {
}


class CountryData {

    static List<Locale> getLocales() {
        final WidgetsBinding instance = WidgetsBinding.instance;
        final List<Locale> systemLocales = instance.window.locales;
        return systemLocales;
        String? isoCountryCode = systemLocales.first.countryCode;

    }

    static const String DEFAULT_LANGUAGE_CODE = "en";

    static List<CountryInfo> getIsoCountries([String languageCode = DEFAULT_LANGUAGE_CODE]) {
        final List<CountryInfo> list = [];
        for (Locale locale in getLocales()) {
            try {
                String name = locale.toLanguageTag();
                String code = locale.getCountry();
                String iso = locale.getISO3Country();
                CountryInfo info = CountryInfo(code, iso, name);
                list.add(info);
            } on Exception catch (e) {
                log("getIsoCountries: $e", error: e);
            }
        }
        return list;
    }

    static CountryInfo getCountryInfo(String code) {
        return getCountryInfo(code, DEFAULT_LANGUAGE_CODE);
    }

    static CountryInfo? getCountryInfo(String code, String language_code) {
        for (CountryInfo info in getIsoCountries(language_code)) {
            if (Validator.isMatched(code.toLowerCase(), info.getCode().toLowerCase())) {
                return info;
            }
        }
        return null;
    }

    static String getName(String code) {
        return getName(code, DEFAULT_LANGUAGE_CODE);
    }

    static String? getName(String code, String language_code) {
        CountryInfo info = getCountryInfo(code, language_code);
        if (info != null) {
            return info.getName();
        } else {
            return null;
        }
    }

    static String getIso(@NonNull String code) {
        return getIso(code, DEFAULT_LANGUAGE_CODE);
    }

    static String? getIso(String code, String language_code) {
        CountryInfo info = getCountryInfo(code, language_code);
        if (info != null) {
            return info.getIso();
        } else {
            return null;
        }
    }

}

class LanguageData {

    static List<LanguageInfo> getIsoLanguages() {
        final List<LanguageInfo> list = [];
        for (String language in Locale.getISOLanguages()) {
            try {
                Locale locale = Locale(language);
                String name = locale.getDisplayLanguage();
                String code = locale.getLanguage();
                String iso = locale.getISO3Language();
                LanguageInfo info = LanguageInfo(code, iso, name);
                list.add(info);
            } on Exception catch (e) {
                log("getIsoLanguages: $e", e);
            }
        }
        return list;
    }

    static LanguageInfo? getLanguageInfo(String code) {
        for (LanguageInfo info in getIsoLanguages()) {
            if (Validator.isMatched(code.toLowerCase(), info.getCode().toLowerCase())) {
                return info;
            }
        }
        return null;
    }

    static String? getName(String code) {
        LanguageInfo info = getLanguageInfo(code);
        if (info != null) {
            return info.getName();
        } else {
            return null;
        }
    }

    static String? getIso(String code) {
        LanguageInfo info = getLanguageInfo(code);
        if (info != null) {
            return info.getIso();
        } else {
            return null;
        }
    }

}