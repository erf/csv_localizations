import 'package:csv_localizations/csv_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'string_ext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        CsvLocalizationsDelegate(
          path: 'assets/translations.csv',
          configurations: CsvLocalizationsConfigurations(
            eol: '\n',
            fieldDelimiter: ',',
            shouldParseNumbers: true,
          ),
        ),
      ],
      supportedLocales: const [
        Locale('en', 'GB'),
        Locale('en', 'US'),
        Locale('en'),
        Locale('nb'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('csv_localizations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hi'.tr,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Image.asset(
            'my_img'.tr,
            width: 64,
            height: 64,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.none,
          ),
          Text(
            'Multiline'.tr,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'num'.numValue.toString(),
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'int'.intValue.toString(),
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'double'.doubleValue.toString(),
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'someStringWeHaventTranslatedYet'.tr,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
