import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

/// store translations per languageCode from a CSV file used by [CsvLocalizationsDelegate]
class CsvLocalizations {
  /// map of translations per languageCode
  final Map<String, Map<String, String>> _localizedValues = {};

  /// path to CSV translation asset
  final String assetPath;

  /// supported language codes (can't get from CSV, since we need it on startup)
  final List<String> supportedLanguageCodes;

  /// language code of current locale, set in [load] method
  String _languageCode;

  // default language code ( the first entry in the Csv file )
  // we don't use it now, but we could use it for default values if translations are not present
  // but i think it's good to NOT use it, so we will alert of missing translations
  //String _defaultCode;

  // true when translations have been loaded from file
  bool _loaded = false;

  /// initialize with asset path to csv and a list of supported language codes
  CsvLocalizations({
    this.assetPath,
    this.supportedLanguageCodes,
  });

  /// first time we call load, we read the csv file and initialize translations
  /// next time we just return this
  /// called by [CsvLocalizationsDelegate]
  Future<CsvLocalizations> load(Locale locale) async {
    this._languageCode = locale.languageCode;
    if (_loaded) return this;
    final String cvsDoc = await rootBundle.loadString(assetPath);
    final List<List<dynamic>> rows = const CsvToListConverter().convert(cvsDoc);
    // i could set supported languages to languages, but we need those at startup..
    final List<String> languages = List<String>.from(rows.first);
    //_defaultCode = languages.first;
    _localizedValues.addEntries(languages.map((e) => MapEntry(e, {})));
    for (int i = 0; i < languages.length; i++) {
      final String languageCode = languages[i];
      rows.forEach((row) {
        final String key = row.first;
        final String value = row[i];
        _localizedValues[languageCode][key] = value;
      });
    }
    _loaded = true;
    return this;
  }

  /// get translation given a key
  String tr(String key) {
    // find translation map given current locale
    final bool containsLocale = _localizedValues.containsKey(_languageCode);
    assert(containsLocale, 'Missing localization for code: $_languageCode');
    final Map<String, String> translations = _localizedValues[_languageCode];
    // find translated string given translation key
    final bool containsKey = translations.containsKey(key);
    assert(containsKey, 'Missing localization for translation key: $key');
    final String translatedValue = translations[key];
    return translatedValue;
  }

  /// helper for getting [CsvLocalizations] object
  static CsvLocalizations of(BuildContext context) =>
      Localizations.of<CsvLocalizations>(context, CsvLocalizations);

  // helper for getting supported language codes from CsvLocalizationsDelegate
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);
}

/// [CsvLocalizationsDelegate] add this to `MaterialApp.localizationsDelegates`
class CsvLocalizationsDelegate extends LocalizationsDelegate<CsvLocalizations> {
  final CsvLocalizations localization;

  const CsvLocalizationsDelegate(this.localization);

  @override
  bool isSupported(Locale locale) => localization.isSupported(locale);

  @override
  Future<CsvLocalizations> load(Locale locale) => localization.load(locale);

  @override
  bool shouldReload(CsvLocalizationsDelegate old) => false;
}

extension LocalizedString on String {
  String tr(BuildContext context) => CsvLocalizations.of(context).tr(this);
}
