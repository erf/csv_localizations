# csv_localizations

A minimal [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) localization package for Flutter.

Store translations for multiple languages in a single CSV file.

One language per column - one translation per row.

## Install

Add `csc_localizations` and `flutter_localizations` to your `pubspec.yaml`.

```yaml
dependencies:
  flutter_localizations: 
    sdk: flutter
  csv_localizations: <last-version>
```

Add a single CSV file asset to your `pubspec.yaml`.

```yaml
flutter:
  assets:
    - assets/translations.csv
```

Add `CsvLocalizationsDelegate` and supported locales to `MaterialApp`.

```Dart
MaterialApp(
  localizationsDelegates: [
    // delegate from flutter_localization
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // delegate from csv_localizations
    CsvLocalizationsDelegate(path: 'assets/translations.csv'),
  ],
  supportedLocales: [
    Locale('en'),
    Locale('nb'),
  ],
}
```

### Note on **iOS**

Add supported locales to `ios/Runner/Info.plist` as described [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales)

Example:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>nb</string>
</array>
```

## Format

A [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file is a simple table-as-a-text-file with comma separated values as columns and new lines as rows.

In our case columns represents translations for a specific language and rows represent translations for a given key.

First row are supported language/country codes. First column are keys for localized values.

Example table:

| key  | en   | nb     |
|------|------|--------|
| Hi   | Hi   | Hei    |
| Dog  | Dog  | Hund   |
| Cat  | Cat  | Cat    |


> Tip (1) wrap multiline strings in quotation marks

Example CSV:

```csv
key,en,nb
Hi,Hi,Hei
Dog,Dog,Hund
Cat,Cat,Katt
my_img,assets/en.png,assets/nb.png
```
> Tip (2) keys can point to local assets like images

## API

Translate text using:

```Dart
CsvLocalizations.instance.string('Hi')
```

Or add a `String` extension:

```Dart
extension LocalizedString on String {
  String tr(BuildContext context) => CsvLocalizations.instance.string(this);
}
```

> We don't want to pollute the String API by default

Now you could easily translate strings like this:

```Dart
'Hi'.tr(context)
```

We use `\n` as the default end-of-line char, but you can change this via `CsvLocalizations.instance.eol`


## Example

See [example](example)
