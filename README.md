# csv_localizations

Localize your app using a single [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file for all translations.

A minimal implementation based on `LocalizationsDelegate`.

## Install

Add package to your `pubspec.yaml`:

```yaml
dependencies:
  csv_localizations:
```

## Usage

Add a CSV translation file as an asset and describe it in your `pubspec.yaml`:

> Tip: Create a Spreadsheet via Google docs, then export as CSV

```yaml
flutter:
  assets:
    - assets/lang.csv
```

The CSV top row list supported language codes, like: **en**, **nb**, etc.

The rows below represent words in those languages.

##### CSV example file

```csv
default, en, nb
Hi, Hi, Hei
Cheese, Cheese, Ost
```

Add `CsvLocalizationsDelegate` to `MaterialApp` and set `supportedLocales`:

```
localizationsDelegates:[
  ... // global delegates
  CsvLocalizationsDelegate(
    CsvLocalizations(
      assetPath: 'assets/lang.csv',
      supportedLanguageCodes: ['en', 'nb'],
    ),
  ),
]
supportedLocales: [Locale('en'), Locale('nb')],

```

Now translate strings using

```dart
  CsvLocalizations.of(context).tr('Hi')
```

or use the simpler String extension method

```dart
  'Hi'.tr(context)
```

#### Note for **iOS**

Add supported locales to 
`ios/Runner/Info.plist` as described [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales).

Example:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>nb</string>
</array>
```

## Example

See [example](example)