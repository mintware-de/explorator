import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('Service Provider Extension', () {
    late MockServiceProviderForTest mockServiceProvider;

    setUp(() {
      mockServiceProvider = MockServiceProviderForTest();
    });

    void _activateKnownServices({
      bool serviceProvider = true,
      bool routeBuilder = true,
      bool navigatorKey = true,
    }) {
      when(mockServiceProvider.has<dynamic>(ServiceProvider))
          .thenReturn(serviceProvider);
      when(mockServiceProvider.has<dynamic>(RouteBuilder))
          .thenReturn(routeBuilder);
      when(mockServiceProvider.has<dynamic>(GlobalKey<NavigatorState>))
          .thenReturn(navigatorKey);
    }

    test('useExplorator register the service provider itself', () {
      _activateKnownServices(serviceProvider: false);

      mockServiceProvider.useExplorator();
      verify(mockServiceProvider.has<dynamic>(ServiceProvider));

      var captured = verify(mockServiceProvider.register<ServiceProvider>(
          captureAny, captureAny));
      expect(
        captured.captured[0](mockServiceProvider),
        same(mockServiceProvider),
      );
      expect(captured.captured[1], const TypeMatcher<Service>());
    });

    test('useExplorator register route builder', () {
      _activateKnownServices(routeBuilder: false);

      var routeBuilder = MaterialRouteBuilder();
      mockServiceProvider.useExplorator(routeBuilder: routeBuilder);
      verify(mockServiceProvider.has<dynamic>(RouteBuilder));

      var captured = verify(
        mockServiceProvider.register<RouteBuilder>(captureAny, captureAny),
      );

      expect(
        captured.captured[0](mockServiceProvider),
        const TypeMatcher<RouteBuilder>(),
      );
      expect(captured.captured[1], const TypeMatcher<Service>());
    });

    test('useExplorator register a global key for the navigator state', () {
      _activateKnownServices(navigatorKey: false);

      var navigatorKey = GlobalKey<NavigatorState>();
      mockServiceProvider.useExplorator(navigatorKey: navigatorKey);
      verify(mockServiceProvider.has<dynamic>(GlobalKey<NavigatorState>));

      var captured = verify(
        mockServiceProvider.register<GlobalKey<NavigatorState>>(
          captureAny,
          captureAny,
        ),
      );

      expect(
        captured.captured[0](mockServiceProvider),
        const TypeMatcher<GlobalKey<NavigatorState>>(),
      );
      expect(captured.captured[1], const TypeMatcher<Service>());
    });
  });
}
