import 'package:flutter/material.dart';
import 'package:csv_localizations/csv_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'string_ext.dart';

void main() {
  CsvLocalizations.instance.eol = '\n';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        CsvLocalizationsDelegate('assets/translations.csv'),
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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        ],
      ),
    );
  }
}
