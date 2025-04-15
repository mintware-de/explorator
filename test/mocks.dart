import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/annotations.dart';

export 'mocks.mocks.dart';

dynamic resolveMock<T>() => false;

@GenerateMocks(
  [
    RouteProvider,
    RouteMatcher,
    NavigatorState,
  ],
  customMocks: [
    MockSpec<ServiceContainerForTest>(fallbackGenerators: {
      #resolve: resolveMock,
    }),
    MockSpec<GlobalKey<NavigatorState>>(
      as: #MockNavigatorKey,
    ),
  ],
)
void main() {}

class ServiceContainerForTest
    implements AbstractServiceContainer, ServiceRegistry {
  @override
  void boot() {}

  @override
  AbstractServiceContainer enhance(
          {List<LazyServiceDescriptor> services = const [],
          Map<String, dynamic> parameters = const {}}) =>
      throw UnimplementedError();

  @override
  bool has<T>([Type? type]) => throw UnimplementedError();

  @override
  Map<String, dynamic> get parameters => throw UnimplementedError();

  @override
  T resolve<T>() => throw UnimplementedError();

  @override
  T? tryResolve<T>() => throw UnimplementedError();

  @override
  List resolveByTag(Symbol tag) => throw UnimplementedError();

  @override
  void register<T>(
    ServiceFactory<T> factory, [
    Service service = const Service(),
  ]) {
    throw UnimplementedError();
  }

  @override
  void applyPlugin(ServiceContainerPlugin plugin) {
    throw UnimplementedError();
  }

  @override
  T resolveOrGetParameter<T>(Type requiredBy, String param,
      [String? parameter]) {
    throw UnimplementedError();
  }

  @override
  T? tryResolveOrGetParameter<T>(String parameter) {
    throw UnimplementedError();
  }
}
