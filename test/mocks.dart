import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:mockito/annotations.dart';

export 'mocks.mocks.dart';

dynamic resolveMock<T>() => false;

@GenerateMocks(
  [
    RouteProvider,
    RouteMatcher,
  ],
  customMocks: [
    MockSpec<ServiceProviderForTest>(fallbackGenerators: {
      #resolve: resolveMock,
    }),
  ],
)
void main() {}

class ServiceProviderForTest
    implements ServiceProvider, EnhanceableProvider, ServiceRegistry {
  @override
  void boot() {}

  @override
  ServiceProvider enhance(
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
}
