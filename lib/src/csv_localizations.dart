import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// Store translations per languageCode from a CSV file used by [CsvLocalizationsDelegate]
class CsvLocalizations {
  /// map of translations per languageCode
  final Map<String, Map<String, String>> _translationsMap = {};

  /// a hash key of language / country code used for [_translationsMap]
  late String _codeKey;

  CsvLocalizations._();

  static final instance = CsvLocalizations._();

  // true when translations have been loaded from file
  bool _loaded = false;

  /// true if csv file have been loaded
  bool get loaded => _loaded;

  /// configure eol before [load]
  String eol = '\n';

  /// read csv file and initialize translations once
  Future<CsvLocalizations> load(
    Locale locale,
    AssetBundle bundle,
    String assetPath,
  ) async {
    final languageCode = locale.languageCode;
    final countryCode = locale.countryCode;

    if (countryCode != null && countryCode.isNotEmpty) {
      _codeKey = '$languageCode-$countryCode';
    } else {
      _codeKey = languageCode;
    }

    if (_loaded) return this;

    final csvDoc = await bundle.loadString(assetPath);
    final rows = CsvToListConverter(eol: eol).convert(csvDoc);
    final languages = List<String>.from(rows.first);
    _translationsMap.addEntries(languages.map((e) => MapEntry(e, {})));
    for (int i = 0; i < languages.length; i++) {
      final String languageCode = languages[i];
      for (final List row in rows) {
        final String key = row.first;
        final String value = row[i];
        _translationsMap[languageCode]![key] = value;
      }
    }
    _loaded = true;
    return this;
  }

  /// get translation given a key
  String string(String key) {
    final containsLocale = _translationsMap.containsKey(_codeKey);
    assert(containsLocale, 'Missing localization for code: $_codeKey');
    final translations = _translationsMap[_codeKey];
    final containsKey = translations!.containsKey(key);
    assert(containsKey, 'Missing localization for translation key: $key');
    return translations[key]!;
  }
}

/// [CsvLocalizationsDelegate] add this to `MaterialApp.localizationsDelegates`
class CsvLocalizationsDelegate extends LocalizationsDelegate<CsvLocalizations> {
  final String csvPath;
  final AssetBundle? assetBundle;

  const CsvLocalizationsDelegate(this.csvPath, [this.assetBundle]);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CsvLocalizations> load(Locale locale) =>
      CsvLocalizations.instance.load(
        locale,
        assetBundle ?? rootBundle,
        csvPath,
      );

  @override
  bool shouldReload(CsvLocalizationsDelegate old) => false;
}
