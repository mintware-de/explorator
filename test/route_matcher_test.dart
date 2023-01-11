import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks.mocks.dart';

void main() {
  group('Route Matcher', () {
    late RouteMatcher matcher;

    setUp(() {
      var mockProvider = MockRouteProvider();
      when(mockProvider.routes).thenReturn([
        RegisteredRoute(path: '/hello', builder: (p0) => (ctx) => Container()),
        RegisteredRoute(
            path: '/hello/{name}', builder: (p0) => (ctx) => Container()),
      ]);
      matcher = RouteMatcher([mockProvider]);
    });

    test('No match will return null', () {
      expect(matcher.match('/foo'), isNull);
    });

    test('On match will return the route', () {
      var match = matcher.match('/hello');
      expect(match, const TypeMatcher<RegisteredRoute>());
      expect(match?.path, equals('/hello'));
    });
  });
}
