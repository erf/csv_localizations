import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// store translations per languageCode from a CSV file used by [CsvLocalizationsDelegate]
class CsvLocalizations {
  /// map of translations per languageCode
  final Map<String, Map<String, String>> _localizedValues = {};

  /// language code of current locale, set in [load] method
  String _languageCode;

  CsvLocalizations._();

  static final instance = CsvLocalizations._();

  // default language code ( the first entry in the Csv file )
  // we don't use it now, but we could use it for default values if translations are not present
  // but i think it's good to NOT use it, so we will alert of missing translations
  //String _defaultCode;

  // true when translations have been loaded from file
  bool _loaded = false;

  bool get loaded => _loaded;

  /// first time we call load, we read the csv file and initialize translations
  /// next time we just return this
  /// called by [CsvLocalizationsDelegate]
  Future<CsvLocalizations> load(
      Locale locale, AssetBundle bundle, String assetPath) async {
    this._languageCode = locale.languageCode;
    if (_loaded) return this;
    String csvDoc = await bundle.loadString(assetPath);
    csvDoc = csvDoc.replaceAll('\r\n', '\n');
    final List<List<dynamic>> rows =
        const CsvToListConverter(eol: '\n').convert(csvDoc.trim());
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
  String string(String key) {
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
}

/// [CsvLocalizationsDelegate] add this to `MaterialApp.localizationsDelegates`
class CsvLocalizationsDelegate extends LocalizationsDelegate<CsvLocalizations> {
  /// path to CSV translation asset
  final String assetPath;

  /// supported language codes (can't get from CSV, since we need it on startup)
  final List<String> supportedLanguageCodes;

  const CsvLocalizationsDelegate({
    @required this.assetPath,
    @required this.supportedLanguageCodes,
  });

  @override
  bool isSupported(Locale locale) {
    return supportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<CsvLocalizations> load(Locale locale) {
    return CsvLocalizations.instance.load(locale, rootBundle, assetPath);
  }

  @override
  bool shouldReload(CsvLocalizationsDelegate old) {
    return false;
  }
}
