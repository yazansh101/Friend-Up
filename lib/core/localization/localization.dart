import 'package:flutter/material.dart';

class AppLocal {
  Locale locale;

  AppLocal(this.locale);

  static List<String> languages() => ['en', 'ar'];

  String get languageCode => locale.toString();

  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  static AppLocal of(BuildContext context) =>
      Localizations.of<AppLocal>(context, AppLocal) ??
      AppLocal(const Locale('en'));
  static const LocalizationsDelegate<AppLocal> delegate =
      _AppLocalizationDelegate();

  String translate(String key, {String nullCase = ""}) {
    return (translateMap[key] ?? {})[languageCode] ?? nullCase;
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocal> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocal.languages().contains(locale.languageCode);

  @override
  Future<AppLocal> load(Locale locale) async {
    AppLocal appLocalizations = AppLocal(locale);
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocal> old) =>
      old != this;
}

const Map<String, Map<String, String>> translateMap = {
  "summary": {'en': "Summary", 'ar': "شرح عن المشروع"},
};
