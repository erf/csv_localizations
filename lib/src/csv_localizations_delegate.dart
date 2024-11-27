import 'package:csv_localizations/src/csv_localizations.dart';
import 'package:csv_localizations/src/csv_localizations_configurations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// A [LocalizationsDelegate] that uses [CsvLocalizations] to load translations.
///
/// The CSV file must have the following format:
///   - The first row is the list of languages.
///   - The first column is the translation keys.
///   - The other columns are the translations per language.
class CsvLocalizationsDelegate extends LocalizationsDelegate<CsvLocalizations> {
  final String path;
  final AssetBundle? assetBundle;
  final CsvLocalizationsConfigurations? configurations;

  const CsvLocalizationsDelegate({
    required this.path,
    this.assetBundle,
    this.configurations,
  });

  @override
  bool isSupported(Locale locale) =>
      CsvLocalizations.instance.isSupported(locale);

  @override
  Future<CsvLocalizations> load(Locale locale) =>
      CsvLocalizations.instance.load(
        locale: locale,
        bundle: assetBundle ?? rootBundle,
        path: path,
        configurations:
            configurations ?? const CsvLocalizationsConfigurations(),
      );

  @override
  bool shouldReload(CsvLocalizationsDelegate old) => false;
}

