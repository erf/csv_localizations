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

The translation file's top row describes language codes, like: **en**, **nb**.

The rows below represent words in various languages.

CSV translation example:

```csv
str, en, nb
Hi, Hi, Hei
Cheese, Cheese, Ost
```

Add `CsvLocalizationsDelegate` to `MaterialApp.localizationsDelegates` and set `MaterialApp.supportedLocales`:

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

Now translate strings using:

```dart
  CsvLocalizations.of(context).tr('Hi')
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