import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// Store translations per languageCode from a CSV file used by [CsvLocalizationsDelegate]
class CsvLocalizations {
  /// map of translations per languageCode
  final Map<String, Map<String, String>> _localizedValues = {};

  /// language code of current locale, set in [load] method
  String _languageCode;

  CsvLocalizations._();

  static final instance = CsvLocalizations._();

  // true when translations have been loaded from file
  bool _loaded = false;

  bool get loaded => _loaded;

  /// you can configure this before [load] is called
  String eol = '\n';

  /// first time we call load, we read the csv file and initialize translations
  /// next time we just return this
  /// called by [CsvLocalizationsDelegate]
  Future<CsvLocalizations> load(
      Locale locale, AssetBundle bundle, String assetPath) async {
    this._languageCode = locale.languageCode;
    if (_loaded) return this;
    final csvDoc = await bundle.loadString(assetPath);
    final rows = CsvToListConverter(eol: eol).convert(csvDoc);
    final languages = List<String>.from(rows.first);
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
    final containsLocale = _localizedValues.containsKey(_languageCode);
    assert(containsLocale, 'Missing localization for code: $_languageCode');
    final translations = _localizedValues[_languageCode];
    final containsKey = translations.containsKey(key);
    assert(containsKey, 'Missing localization for translation key: $key');
    return translations[key];
  }
}

/// [CsvLocalizationsDelegate] add this to `MaterialApp.localizationsDelegates`
class CsvLocalizationsDelegate extends LocalizationsDelegate<CsvLocalizations> {
  /// path to CSV translation asset
  final String assetPath;

  const CsvLocalizationsDelegate(this.assetPath);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CsvLocalizations> load(Locale locale) =>
      CsvLocalizations.instance.load(locale, rootBundle, assetPath);

  @override
  bool shouldReload(CsvLocalizationsDelegate old) => false;
}
