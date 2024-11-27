import 'package:csv/csv.dart';
import 'package:csv_localizations/src/csv_localizations_configurations.dart';
import 'package:flutter/widgets.dart';

/// [CsvLocalizations] is used to load translations from a CSV file.
class CsvLocalizations {
  /// Map of translations per languageCode
  final Map<String, Map<String, dynamic>> _translationsMap = {};

  /// A key of language / country code used for [_translationsMap]
  late String _langTag;

  /// [CsvLocalizations] constructor.
  CsvLocalizations._();

  /// [CsvLocalizations] instance.
  static final instance = CsvLocalizations._();

  /// Load the CSV file and add translations per language.
  Future<CsvLocalizations> load({
    required Locale locale,
    required AssetBundle bundle,
    required String path,
    CsvLocalizationsConfigurations? configurations,
  }) async {
    _langTag = locale.toLanguageTag();
    final String csvDoc = await bundle.loadString(path);
    final List<List<dynamic>> rows = CsvToListConverter(
      fieldDelimiter: configurations?.fieldDelimiter,
      textDelimiter: configurations?.textDelimiter,
      textEndDelimiter: configurations?.textEndDelimiter,
      eol: configurations?.eol,
      convertEmptyTo: configurations?.convertEmptyTo,
      allowInvalid: configurations?.allowInvalid,
      shouldParseNumbers: configurations?.shouldParseNumbers,
    ).convert<dynamic>(csvDoc);
    final List<String> languages = List<String>.from(rows.first);
    _translationsMap.addEntries(languages.map((lang) => MapEntry(lang, {})));
    for (int i = 0; i < languages.length; i++) {
      final String languageCode = languages[i];
      for (final List row in rows) {
        final String key = row.first;
        final dynamic value = row[i];
        _translationsMap[languageCode]![key] = value;
      }
    }
    return this;
  }

  /// Return true if the [locale] is supported.
  bool isSupported(Locale locale) {
    return true;
    // TODO this does not work, because the CSV file is not loaded yet
    //return _translationsMap.containsKey(locale.toLanguageTag());
  }

  /// Get the translation for the given [key].
  String string(String key) {
    return _translationsMap[_langTag]![key] ?? key;
  }

  /// get the num value for the given [key].
  num numValue(String key) {
    return _translationsMap[_langTag]![key]!;
  }

  /// get the int value for the given [key].
  int intValue(String key) {
    return _translationsMap[_langTag]![key]!;
  }

  /// get the double value for the given [key].
  double doubleValue(String key) {
    return _translationsMap[_langTag]![key]!;
  }
}
