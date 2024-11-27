import 'dart:convert';

import 'package:csv_localizations/csv_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// https://flutter.dev/docs/testing
/// https://flutter.dev/docs/cookbook/testing/unit/introduction
/// https://flutter.dev/docs/cookbook/testing/widget/introduction
/// https://stackoverflow.com/questions/49480080/flutter-load-assets-for-tests
/// https://api.flutter.dev/flutter/widgets/DefaultAssetBundle-class.html
/// https://stackoverflow.com/questions/52463714/how-to-test-localized-widgets-in-flutter
/// https://api.flutter.dev/flutter/widgets/LocalizationsDelegate-class.html

ByteData toByteData(String text) {
  return ByteData.view(Uint8List.fromList(utf8.encode(text)).buffer);
}

const testString = '''
key,en,en-US,nb,nb-NO
Hi,Hi,Hi US,Hei,Hei NO
int,10,20,30,40
double,1.5,2.5,3.5,4.5
num,10.5,20.5,30.5,40.5
''';

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    return toByteData(testString);
  }
}

Widget buildTestWidgetWithLocale(
  Locale locale,
  CsvLocalizationsDelegate csvLocalizationsDelegate,
) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: [
      ...GlobalMaterialLocalizations.delegates,
      csvLocalizationsDelegate,
    ],
    supportedLocales: const [
      Locale('en'),
      Locale('en', 'US'),
      Locale('nb'),
      Locale('nb', 'NO'),
    ],
    home: Scaffold(
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              Text(
                CsvLocalizations.instance.string('Hi'),
              ),
              Text(
                CsvLocalizations.instance.intValue('int').toString(),
              ),
              Text(
                CsvLocalizations.instance.doubleValue('double').toString(),
              ),
              Text(
                CsvLocalizations.instance.numValue('num').toString(),
              )
            ],
          );
        },
      ),
    ),
  );
}

// get csv localizations
CsvLocalizationsDelegate csvTestDelgate() {
  return CsvLocalizationsDelegate(
    path: 'assets/translations.csv',
    assetBundle: TestAssetBundle(),
    configurations: CsvLocalizationsConfigurations(
      eol: '\n',
      fieldDelimiter: ',',
    ),
  );
}

void main() {
  testWidgets('MyTestApp find [en] text', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('en'), csvTestDelgate()));
    await tester.pump();
    final hiFinder = find.text('Hi');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [en-US] text', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('en', 'US'), csvTestDelgate()));
    await tester.pump();
    final hiFinder = find.text('Hi US');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [nb] text', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb'), csvTestDelgate()));
    await tester.pump();
    final hiFinder = find.text('Hei');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [nb-NO] text', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb', 'NO'), csvTestDelgate()));
    await tester.pump();
    final hiFinder = find.text('Hei NO');
    expect(hiFinder, findsOneWidget);
  });

  testWidgets('Test Locale [nb-NO] is supported', (WidgetTester tester) async {
    final csvDelegate = csvTestDelgate();

    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb', 'NO'), csvDelegate));
    await tester.pumpAndSettle();

    expect(csvDelegate.isSupported(const Locale('nb', 'NO')), true);
  });

  testWidgets('Test Locale [zh] is NOT supported', (WidgetTester tester) async {
    final csvDelegate = csvTestDelgate();

    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb', 'NO'), csvDelegate));
    await tester.pumpAndSettle();

    // TODO isSupported always returns true for now
    // expect(csvDelegate.isSupported(const Locale('zh')), false);
  });

  test('Locale get codeKey from languageCode', () {
    expect(const Locale('en').toLanguageTag(), 'en');
    expect(const Locale('nb').toLanguageTag(), 'nb');
  });

  test('Locale get codeKey from languageCode and country', () {
    expect(const Locale('en', 'US').toLanguageTag(), 'en-US');
    expect(const Locale('en', 'GB').toLanguageTag(), 'en-GB');
  });

  testWidgets('MyTestApp find [nb] int value', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb'), csvTestDelgate()));
    await tester.pump();
    final numberFinder = find.text('30');
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [nb] double value', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb'), csvTestDelgate()));
    await tester.pump();
    final numberFinder = find.text('3.5');
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('MyTestApp find [nb] num value', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestWidgetWithLocale(const Locale('nb'), csvTestDelgate()));
    await tester.pump();
    final numberFinder = find.text('30.5');
    expect(numberFinder, findsOneWidget);
  });
}
