#!/bin/sh
rm -rf build
rm -rf coverage
flutter clean
##  Install dependencies
flutter pub get
## Verify formatting
dart format --output=none --set-exit-if-changed .
## Analyze project source
flutter analyze

## Run tests
flutter test --coverage -r github

## Check publish warnings
flutter pub publish --dry-run