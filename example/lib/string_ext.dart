import 'package:csv_localizations/csv_localizations.dart';

extension StringExt on String {
  String get tr => CsvLocalizations.instance.string(this);
}
