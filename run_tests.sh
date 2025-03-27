#!/bin/sh
rm -rf .dart_tool
rm lib/explorator.catalyst_builder.plugin.g.dart
dart run build_runner build --delete-conflicting-outputs
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/explorator.dart' 'lib/explorator.catalyst_builder.plugin.g.dart' -o coverage/lcov.info
genhtml ./coverage/lcov.info -o ./coverage/html
