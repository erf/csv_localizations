# csv_localizations

A minimal [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) localization package for Flutter.

## Rationale

A single CSV file allows you to represent translations for all languages. This makes it easy to store, share and add new translations. 

For longer, multi-line and complex strings, consider using [toml_localizations](https://github.com/erf/toml_localizations) or [yaml_localizations](https://github.com/erf/yaml_localizations), in addition to this.

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

Example CSV file:

```csv
key, en, nb
Hi, Hi, Hei
my_img,assets/en.png,assets/nb.png
```

> First row is supported language codes; below are localizations. Left column are keys for localized values to the right.
> 
> Tip: keys can point to local assets like images etc.

### MaterialApp

Add `CsvLocalizationsDelegate` to `MaterialApp` and set `supportedLocales` using
language codes.

```
MaterialApp(
  localizationsDelegates: [
    ... // global delegates
    CsvLocalizationsDelegate(
      CsvLocalizations(
        assetPath: 'assets/lang.csv',
        supportedLanguageCodes: [ 'en', 'nb', ],
      ),
    ),
  ],
  supportedLocales: [ Locale('en'), Locale('nb'), ],
}

```

### API

Translate strings using

```dart
CsvLocalizations.of(context).string('Hi')
```

Localize an image by pointing to various local assets

```dart
Image.asset(CsvLocalizations.of(context).string('my_img'))
```

We keep the API simple, but you can easily add an extension method to `String` like this:

```dart
extension LocalizedString on String {
  String tr(BuildContext context) => CsvLocalizations.of(context).string(this);
}
```

### Note on **iOS**

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
