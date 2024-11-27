import 'package:csv/csv.dart';
import 'package:csv_localizations/src/csv_localizations_configurations.dart';
import 'package:flutter/widgets.dart';

/// [CsvLocalizations] is used to load translations from a CSV file.
class CsvLocalizations {
  /// Map of translations per languageCode
  final Map<String, Map<String, String>> _translationsMap = {};

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
    final csvDoc = await bundle.loadString(path);
    final rows = CsvToListConverter(
      fieldDelimiter: configurations?.fieldDelimiter,
      textDelimiter: configurations?.textDelimiter,
      textEndDelimiter: configurations?.textEndDelimiter,
      eol: configurations?.eol,
      convertEmptyTo: configurations?.convertEmptyTo,
      allowInvalid: configurations?.allowInvalid,
      shouldParseNumbers: configurations?.shouldParseNumbers,
    ).convert(csvDoc);
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
    return _translationsMap[_langTag]![key]!;
  }
}

