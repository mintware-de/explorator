import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('Service Provider Extension', () {
    late MockServiceProviderForTest mockServiceProvider;

    setUp(() {
      mockServiceProvider = MockServiceProviderForTest();
    });

    test('useExplorator register the service provider itself', () {
      when(mockServiceProvider.has<dynamic>(ServiceProvider)).thenReturn(false);

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
      when(mockServiceProvider.has<dynamic>(ServiceProvider)).thenReturn(true);
      when(mockServiceProvider.has<dynamic>(RouteBuilder)).thenReturn(false);

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
  });
}
