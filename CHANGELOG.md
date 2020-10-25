# CHANGELOG

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
