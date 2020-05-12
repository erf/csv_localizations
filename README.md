# csv_localizations

Localize your Flutter app using a single [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file

## Usage

See [example](example)

### Install

Add package to your `pubspec.yaml`

```yaml
dependencies:
  csv_localizations:
```

### Add CSV asset

Add a CSV translation file as an asset and describe it in your `pubspec.yaml`

> Tip: Create a Spreadsheet via Google docs, then export as CSV

```yaml
flutter:
  assets:
    - assets/lang.csv
```

##### CSV example file

Top row show supported language codes; rows below show translations

```csv
key, en, nb
Hi, Hi, Hei
Cheese, Cheese, Ost
my_img,assets/en.png,assets/nb.png,assets/da.png
```

> Note: keys can point to local assets like images etc.

### In code

Add `CsvLocalizationsDelegate` to `MaterialApp` and set `supportedLocales`

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

### API

Now translate strings using

```dart
  CsvLocalizations.of(context).tr('Hi')
```

Or use the simpler String extension method

```dart
  'Hi'.tr(context)
```

Or load a localized image

```dart
  Image.asset('my_img'.tr(context))
```

### Note on **iOS**

Add supported locales to 
`ios/Runner/Info.plist` as described [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales).

Example:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>nb</string>
	<string>da</string>
</array>
```
