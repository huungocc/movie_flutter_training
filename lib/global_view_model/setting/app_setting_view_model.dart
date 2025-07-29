import 'package:flutter/material.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/database/share_preferences_helper.dart';
import 'package:movie_flutter_training/models/enums/language.dart';

class AppSettingProvider extends ChangeNotifier {
  Language _language = AppConfigs.defaultLanguage;

  Language get language => _language;

  Locale get locale => _language.local;

  Future<void> getInitialSetting() async {
    final currentLanguage = await SharedPreferencesHelper.getCurrentLanguage();
    _language = currentLanguage ?? AppConfigs.defaultLanguage;
    notifyListeners();
  }

  Future<void> changeLanguage(Language newLang) async {
    await SharedPreferencesHelper.setCurrentLanguage(newLang);
    _language = newLang;
    notifyListeners();
  }
}
