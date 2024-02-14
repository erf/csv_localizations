# CHANGELOG

## [1.6.0+1] - 14 feb 2024
- update README

## [1.6.0] - 6 dec 2023
- update csv 5.0.1 -> 5.1.1
- update flutter_lits 1.0.4 -> 3.0.1
- update sdk environment ">=2.12.0 <3.0.0" -> ">=2.18.0 <4.0.0"

## [1.5.0] - 5 may 2022
- API: remove loaded
- use Locale.toLanguageTag to build key
- improve DOCS

## [1.4.0] - 8 mar 2022
- fix tests by adding GlobalMaterialLocalizations.delegates
- add lints
- replace forEach with for loop
- use const 
- don't interpolate string

## [1.3.0] - 2 dec 2021
- update csv package to 5.0.1

## [1.2.0+1] - 1 aug 2021
- simplify README.md

## [1.2.0] - 16 march 2021
- change min Dart version: 2.12.0-0 -> 2.12.0

## [1.1.0] - 16 march 2021
- update csv to 5.0.0

## [1.0.0] - 3 march 2021
- stable null-safety release !
- added widget tests
- pass optional asset bundle

## [0.9.0-nullsafety.0] - 2 feb 2021
- updated csv package and migrated to nullsafety

## [0.8.0+1]
- improve description (and pub convention score..)

## [0.8.0]
- support country codes
- remove the need to set supportedLanguageCodes

## [0.7.0]
- update csv dependency to 4.1.0
- update README

## [0.6.0]
I don't manipulate the CSV file anymore, but you can set the prefered `eol` now
which defaults to `\n`.

## [0.5.0]
Decided to simplify the API again by removing the string extenstion `tr`.

This makes more sense if we want to use multiple localization libraries.

Moved `string_ext` to the `example` folder if you want to use it.

## [0.4.0]
- added CsvLocalizations.instance to avoid the need for a BuildContext
- added String extension getter 'tr'

## [0.3.0]
- use \n as default eol but replace \r\n with \n before parse
- improve README 
- add multiline example

## [0.2.0+3]

- update README

## [0.2.0+2]

- add rationale to README

## [0.2.0+1]

- tweak example and remove danish

## [0.2.0]

- simplify API to use a single `string` method. We don't want to pollute String with extensions
methods. Users can add (and name) these themselves as they see fit.

## [0.1.5]

- trim CSV file for leading and trailing spaces

## [0.1.4]

- update README

## [0.1.3]

- update README with localized image example

## [0.1.2]

- update README

## [0.1.1]

- update README

## [0.1.0]

- add String extension translate method 'Hi'.tr(context)
- update README

## [0.0.1]

- initial release
- localize app using a single csv file
