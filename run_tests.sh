#!/bin/sh
flutter pub run build_runner build --delete-conflicting-outputs
flutter test --coverage
genhtml ./coverage/lcov.info -o ./coverage/html
