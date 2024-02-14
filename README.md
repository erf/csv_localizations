# csv_localizations

A minimal [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) localization package for Flutter.

Store translations for multiple languages in a single CSV file. One language per column - one translation per row.

### Install

Add `csc_localizations` and `flutter_localizations` to your `pubspec.yaml`.

```yaml
dependencies:
  flutter_localizations: 
    sdk: flutter
  csv_localizations: <last-version>
```

### Add a single CSV asset file

Add a single CSV file asset to your `pubspec.yaml`.

```yaml
flutter:
  assets:
    - assets/translations.csv
```

#### Example CSV file

```csv
key,en,nb
Hi,Hi,Hei
Dog,Dog,Hund
Cat,Cat,Katt
my_img,assets/en.png,assets/nb.png
```

> Tip: keys can point to local assets like images etc.

### Format

| key  | en   | nb     |
|------|------|--------|
| Hi   | Hi   | Hei    |
| Dog  | Dog  | Hund   |
| Cat  | Cat  | Cat    |

First row lists supported language/country codes. First column are keys for
localized values.

> Tip: you can wrap multiline strings in quotation marks

## API

Translate String's using:

```Dart
CsvLocalizations.instance.string('Hi')
```

or add a `String` extension:

> We keep the API simple as to not pollute the String API

```Dart
extension LocalizedString on String {
  String tr(BuildContext context) => CsvLocalizations.instance.string(this);
}
```

We use `\n` as the default **eol** (end-of-line) char, but you can set this via
`CsvLocalizations.instance.eol`.

### MaterialApp

Add `CsvLocalizationsDelegate` to `MaterialApp` and set `supportedLocales` using
language codes.

```
MaterialApp(
  localizationsDelegates: [
    // delegate from flutter_localization
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // delegate from csv_localizations
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
	<string>nb</string>
</array>
```

## Example

See [example](example).

