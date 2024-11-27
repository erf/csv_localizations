import 'package:csv_localizations/csv_localizations.dart';

extension StringExt on String {
  String get tr => CsvLocalizations.instance.string(this);

  num get numValue => CsvLocalizations.instance.numValue(this);

  int get intValue => CsvLocalizations.instance.intValue(this);

  double get doubleValue => CsvLocalizations.instance.doubleValue(this);
}
