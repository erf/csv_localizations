# csv_localizations

[CSV](https://en.wikipedia.org/wiki/Comma-separated_values) localization package
for Flutter.

Store translations for multiple languages in a single CSV file.

Consider using [toml_localizations](https://github.com/erf/toml_localizations)
or [yaml_localizations](https://github.com/erf/yaml_localizations) for separate
files per language.

## Usage

See [example](example).

### Install

Add to your `pubspec.yaml`

```yaml
dependencies:
  csv_localizations:
```

### Add a single CSV asset file

Add a single CSV file as an asset and describe it in your `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/translations.csv
```

#### Example CSV file

```csv
key,en,nb,en-GB,en-US
Hi,Hi,Hei,Hi GB,Hi US
my_img,assets/en.png,assets/nb.png,assets/en.png,assets/en.png
Multiline,"This is a
  multiline string","Denne teksten går over
  flere linjer","This is a
  multiline string","This is a
  multiline string"
```

> Tip: keys can point to local assets like images etc.

### Format

| key  | en-GB | en   | nb     |
|------|-------|------|--------|
| Hi   | Hi    | Hi   | Hei    |
| Bike | Bike  | Bike | Sykkel |
| Dog  | Dog   | Dog  | Hund   |

First row lists supported language/country codes.

First column are keys for localized values.

You can wrap multiline strings in quotation marks.

## API

Translate strings using

```dart
CsvLocalizations.instance.string('Hi')
```

We keep the API simple, but you can easily add an extension method to `String`
like this:

```dart
extension LocalizedString on String {
  String tr(BuildContext context) => CsvLocalizations.instance.string(this);
}
```

We use `\n` as the default **eol** (end-of-line) char, but you can set this via
`CsvLocalizations.instance.eol`.

Check if the translation file is loaded using `CsvLocalizations.instance.loaded`.
Only necessary if called before initializing the global localizationDelegates.

### MaterialApp

Add `CsvLocalizationsDelegate` to `MaterialApp` and set `supportedLocales` using
language codes.

```
MaterialApp(
  localizationsDelegates: [
    ... // global delegates
    CsvLocalizationsDelegate('assets/translations.csv'),
  ],
  supportedLocales: [
    Locale('en', 'GB'),
    Locale('en', 'US'),
    Locale('en'),
    Locale('nb'),
  ],
}

```

## Note on **iOS**

Add supported languages to `ios/Runner/Info.plist` as described
[here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales).

Example:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>en-US</string>
	<string>en-GB</string>
	<string>nb</string>
</array>
```
