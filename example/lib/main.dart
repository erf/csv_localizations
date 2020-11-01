import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:csv_localizations/csv_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'string_ext.dart';

void main() {

  CsvLocalizations.instance.eol = '\n';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        CsvLocalizationsDelegate(
          assetPath: 'assets/translations.csv',
          supportedLanguageCodes: ['en', 'nb'],
        ),
      ],
      supportedLocales: [
        Locale('en'),
        Locale('nb'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('csv_localizations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hi'.tr,
            style: TextStyle(
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
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
