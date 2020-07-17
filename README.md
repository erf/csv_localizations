# csv_localizations

A minimal [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) localization package for Flutter.

Store translations for multiple languages in a single CSV file.

Consider [toml_localizations](https://github.com/erf/toml_localizations) or [yaml_localizations](https://github.com/erf/yaml_localizations) for separate files per language.

## Usage

See [example](example).

### Install

Add to your `pubspec.yaml`

```yaml
dependencies:
  csv_localizations:
```

### Add CSV asset file

Add a CSV file as an asset and describe it in your `pubspec.yaml`

> Tip: Create a Spreadsheet via Google docs, then export as CSV

```yaml
flutter:
  assets:
    - assets/lang.csv
```

### Example CSV file

```csv
key,en,nb
Hi,Hi,Hei
my_img,assets/en.png,assets/nb.png
Multiline,"This
  is a multiline 
string","Denne
  teksten går over flere 
linjer"
```

> Tip: keys can point to local assets like images etc.

### Format

First row lists supported language codes. 

First column are keys for localized values.

Wrap multiline strings in quotation marks.

We use the [csv](https://pub.dev/packages/csv) package for parsing, but we use `\n` as the default **eol** and replace `\r\n` with `\n` before parsing.

### MaterialApp

Add `CsvLocalizationsDelegate` to `MaterialApp` and set `supportedLocales` using
language codes.

```
MaterialApp(
  localizationsDelegates: [
    ... // global delegates
    CsvLocalizationsDelegate(
      assetPath: 'assets/lang.csv',
      supportedLanguageCodes: [ 'en', 'nb', ],
    ),
  ],
  supportedLocales: [ Locale('en'), Locale('nb'), ],
}

```

## API

Translate strings using

```dart
CsvLocalizations.instance.string('Hi')
```

> Note: From version 0.4.0 we use a singleton for the CsvLocalizations instance

Or using the `String` extension getter `tr` like this:

```dart
'Hi'.tr
```

## Note on **iOS**

Add supported languages to `ios/Runner/Info.plist` as described 
[here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales).

Example:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>nb</string>
</array>
```
