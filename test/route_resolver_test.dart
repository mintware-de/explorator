import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks.mocks.dart';

void main() {
  late RouteResolver resolver;
  late MockServiceProviderForTest mockServiceProvider;
  late List<LazyServiceDescriptor> enhancedServices;
  late Map<String, dynamic> enhancedParameters;

  setUp(() {
    enhancedServices = [];
    enhancedParameters = {};

    mockServiceProvider = MockServiceProviderForTest();
    when(mockServiceProvider.enhance(
      services: anyNamed('services'),
      parameters: anyNamed('parameters'),
    )).thenAnswer((realInvocation) {
      enhancedServices.addAll(realInvocation.namedArguments[#services]);
      enhancedParameters.addAll(realInvocation.namedArguments[#parameters]);
      return mockServiceProvider;
    });

    var mockProvider = MockRouteProvider();
    when(mockProvider.routes).thenReturn([
      RegisteredRoute(path: '/hello', builder: (p0) => (ctx) => Container()),
      RegisteredRoute(
          path: '/hello/{name}', builder: (p0) => (ctx) => Container()),
    ]);
    resolver = RouteResolver(
        [mockProvider], MaterialRouteBuilder(), mockServiceProvider);
  });

  test('resolve not existing', () {
    var resolved =
        resolver.resolveRoute(const RouteSettings(name: '/not-existing'));
    expect(resolved, isNull);
  });

  test('resolve simple', () {
    var resolved = resolver.resolveRoute(const RouteSettings(name: '%2Fhello'));
    expect(resolved, isNotNull);

    expect(enhancedServices, isNotEmpty);
    var first = enhancedServices.first;
    var args = first.factory(mockServiceProvider) as RouteArguments;
    expect(first.service.exposeAs, equals(RouteArguments));
    expect(first.service.lifetime, equals(ServiceLifetime.transient));
    expect(args.pathVariables, isEmpty);
    expect(args.queryParameters, isEmpty);
  });

  test('resolve with arguments', () {
    var resolved =
        resolver.resolveRoute(const RouteSettings(name: '/hello/foo'));
    var args =
        enhancedServices.first.factory(mockServiceProvider) as RouteArguments;
    expect(args.pathVariables, equals({'name': 'foo'}));
    expect(resolved, isNotNull);
  });

  test('resolve with query parameters', () {
    var resolved =
        resolver.resolveRoute(const RouteSettings(name: '/hello?a=b'));
    var args =
        enhancedServices.first.factory(mockServiceProvider) as RouteArguments;
    expect(args.queryParameters, equals({'a': 'b'}));
    expect(resolved, isNotNull);
  });

  test('resolve with arguments and query parameters', () {
    var resolved =
        resolver.resolveRoute(const RouteSettings(name: '/hello/foo?a=b'));
    var args =
        enhancedServices.first.factory(mockServiceProvider) as RouteArguments;
    expect(args.pathVariables, equals({'name': 'foo'}));
    expect(args.queryParameters, equals({'a': 'b'}));
    expect(resolved, isNotNull);
  });
}
