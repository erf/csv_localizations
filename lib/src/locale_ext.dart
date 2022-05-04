import 'dart:ui';

extension LocaleExt on Locale {
  String get codeKey {
    if (countryCode == null || countryCode!.isEmpty) {
      return languageCode;
    } else {
      return '$languageCode-$countryCode';
    }
  }
}
