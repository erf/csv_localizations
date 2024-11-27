/// [CsvLocalizationsConfigurations] is used to configure the CSV parser.
class CsvLocalizationsConfigurations {
  /// Configuration fieldDelimiter (default is ',', another common is ';')
  final String fieldDelimiter;

  /// Configuration textDelimiter
  final String textDelimiter;

  /// Configuration textEndDelimiter
  final String textEndDelimiter;

  /// Configuration eol
  final String eol;

  /// Configuration convertEmptyTo
  final String convertEmptyTo;

  /// Configuration allowInvalid
  final bool allowInvalid;

  /// Configuration shouldParseNumbers
  final bool shouldParseNumbers;

  /// [CsvLocalizationsConfigurations] constructor.
  const CsvLocalizationsConfigurations({
    this.fieldDelimiter = ',',
    this.textDelimiter = '"',
    this.textEndDelimiter = '"',
    this.eol = '\n',
    this.convertEmptyTo = '',
    this.allowInvalid = true,
    this.shouldParseNumbers = true,
  });
}
