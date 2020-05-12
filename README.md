# csv_localizations

Localize your Flutter app using a single [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file.

A minimal localization package built on `LocalizationsDelegate`.

## Usage

See [example](example)

### Install

Add package to your `pubspec.yaml`

```yaml
dependencies:
  csv_localizations:
```

### Add CSV asset file

Add a CSV translation file as an asset and describe it in your `pubspec.yaml`

> Tip: Create a Spreadsheet via Google docs, then export as CSV

```yaml
flutter:
  assets:
    - assets/lang.csv
```

##### CSV example


```csv
key, en, nb
Hi, Hi, Hei
Cheese, Cheese, Ost
my_img,assets/en.png,assets/nb.png
```

> Top row show supported language codes; rows below are localizations. 
> 
> Left column are keys for localized values.
> 
> Note: keys can point to local assets like images etc.

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
  CsvLocalizations.of(context).tr('Hi')
```

or use the simpler String extension method

```dart
  'Hi'.tr(context)
```

Localize an image by pointing to various local assets

```dart
  Image.asset('my_img'.tr(context))
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
