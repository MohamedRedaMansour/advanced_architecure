import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

import '../../../core/data_sources/local/shared_perference.dart';
import '../../../generated/l10n.dart';

/// Saves and loads information regarding localization settings
///
class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit({
    required this.sharedPrefsClient,
  }) : super(initialLocale);
  final SharedPreferencesHelper sharedPrefsClient;

  /// check English Supported Locale
  static bool isLocaleEn = ui.window.locale.languageCode == 'en';

  /// check Arabic Supported Locale
  static bool isLocaleAr = ui.window.locale.languageCode == 'ar';

  /// Arabic Supported Locale
  static const Locale localeAr = Locale('ar');

  /// Contains all our localizationDelegates
  final List<LocalizationsDelegate> localizationDelegates = [
    AppLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  /// Returns supported locales by the app.
  List<Locale> get supportedLocales =>
      AppLocalization.delegate.supportedLocales;

  /// maps the [supportedLocales] to languageCodes for the language selection dropdown
  List<String> get supportedLanguageCodes =>
      supportedLocales.map((locale) => locale.languageCode).toList();

  /// Gets default locale for the application i.e.: english
  static Locale get _defaultLocale =>
      AppLocalization.delegate.supportedLocales[1];

  /// Returns the current locale if it's  [_isLocaleSupported]
  /// otherwise it returns the apps default locale [_defaultLocale]
  static Locale get initialLocale {
    Locale locale = getCurrentLocale();
    return _isLocaleSupported(locale) ? locale : _defaultLocale;
  }

  /// Returns current locale without the CountryCode
  static Locale getCurrentLocale() {
    String languageCode = ui.window.locale.languageCode;
    return Locale(languageCode);
  }

  /// Checks if locale is supported using the [AppLocalizations.supportedLocales]
  static bool _isLocaleSupported(Locale locale) =>
      AppLocalization.delegate.supportedLocales.contains(locale);

  Locale currentLocale() => state;

  /// Update locale used in the app to Locale if supported
  void updateLocale(
    Locale locale, {
    bool shouldUpdateLanguageInServer = false,
  }) {
    if (supportedLocales.contains(locale)) {
      //todo update language using shared preferences
      emit(locale);
    }
  }

  /// Update locale used in the app to English
  void updateLocaleToEnglish({bool shouldUpdateLanguageInServer = false}) =>
      updateLocale(const Locale('en'),
          shouldUpdateLanguageInServer: shouldUpdateLanguageInServer);

  /// Update locale used in the app to Arabic
  void updateLocaleToArabic({bool shouldUpdateLanguageInServer = false}) =>
      updateLocale(const Locale('ar'),
          shouldUpdateLanguageInServer: shouldUpdateLanguageInServer);
}
