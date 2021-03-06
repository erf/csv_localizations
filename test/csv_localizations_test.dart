import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:csv_localizations/csv_localizations.dart';

/// https://flutter.dev/docs/testing
/// https://flutter.dev/docs/cookbook/testing/unit/introduction
/// https://flutter.dev/docs/cookbook/testing/widget/introduction
/// https://stackoverflow.com/questions/49480080/flutter-load-assets-for-tests
/// https://api.flutter.dev/flutter/widgets/DefaultAssetBundle-class.html
/// https://stackoverflow.com/questions/52463714/how-to-test-localized-widgets-in-flutter
/// https://dart.dev/null-safety/migration-guide

ByteData toByteData(String text) {
  return ByteData.view(Uint8List.fromList(utf8.encode(text)).buffer);
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    return toByteData('key,en,en-US,nb,nb-NO\nHi,Hi,Hi US,Hei,Hei NO');
  }
}

Widget buildTestWidgetWithLocale(Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: [
      CsvLocalizationsDelegate(
        'assets/translations.csv',
        TestAssetBundle(),
      ),
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('en'),
      Locale('en', 'US'),
      Locale('nb'),
      Locale('nb', 'NO'),
    ],
    home: Scaffold(
      body: Builder(
        builder: (context) => Text(CsvLocalizations.instance.string('Hi')),
      ),
    ),
  );
}

void main() {
  testWidgets('MyTestApp find [en] text', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidgetWithLocale(Locale('en')));
    await tester.pump();
    final hiFinder = find.text('Hi');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [en-US] text', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidgetWithLocale(Locale('en', 'US')));
    await tester.pump();
    final hiFinder = find.text('Hi US');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [nb] text', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidgetWithLocale(Locale('nb')));
    await tester.pump();
    final hiFinder = find.text('Hei');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [nb-NO] text', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidgetWithLocale(Locale('nb', 'NO')));
    await tester.pump();
    final hiFinder = find.text('Hei NO');
    expect(hiFinder, findsOneWidget);
  });
}
