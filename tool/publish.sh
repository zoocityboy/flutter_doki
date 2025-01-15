#!/bin/sh
mv README.md README.md.bak
mv README_publish.md README.md
flutter pub publish
mv README.md README_publish.md
mv README.md.bak README.md