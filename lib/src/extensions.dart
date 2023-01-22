import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';

/// This extension simplifies the configuration for the explorator package.
extension ServiceProviderExtension on ServiceProvider {
  /// Register necessary services for using the explorator package.
  void useExplorator({
    RouteBuilder? routeBuilder,
  }) {
    if (this is! ServiceRegistry) return;

    _addServiceProvider();
    _addRouteBuilder(routeBuilder);
  }

  void _addServiceProvider() {
    if (has<dynamic>(ServiceProvider)) return;

    (this as ServiceRegistry).register<ServiceProvider>(
      (p) => this,
      const Service(
        exposeAs: ServiceProvider,
        lifetime: ServiceLifetime.singleton,
      ),
    );
  }

  void _addRouteBuilder(RouteBuilder? routeBuilder) {
    if (routeBuilder == null || has<dynamic>(RouteBuilder)) return;

    (this as ServiceRegistry).register<RouteBuilder>(
      (p) => routeBuilder,
      const Service(
        exposeAs: RouteBuilder,
        lifetime: ServiceLifetime.singleton,
      ),
    );
  }
}
