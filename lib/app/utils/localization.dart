import 'dart:ui';

import 'package:get/get.dart';

import '../translation/en_US.dart';
import '../translation/fr.dart';
import '../translation/ur_PK.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', "US");

  static final langs = ['English', "Urdu", 'France'];

  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('fr', null)
  ];
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {'en_US': en, 'ur_PK': ur, 'fr': fr};

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    int index = langs.indexOf(lang);
    return locales[index];
  }
}
