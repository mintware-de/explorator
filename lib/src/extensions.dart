import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';

/// This extension simplifies the configuration for the explorator package.
extension ServiceProviderExtension on ServiceProvider {
  /// Register necessary services for using the explorator package.
  /// The [routeBuilder] is used to construct the [Route] instance.
  /// The [navigatorKey] is necessary to navigate using the [Routing] class.
  /// If the [navigatorKey] is null, a new key will be created and registered.
  void useExplorator({
    RouteBuilder? routeBuilder,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    if (this is! ServiceRegistry) return;

    _addServiceProvider();
    _addRouteBuilder(routeBuilder);
    _addNavigatorKey(navigatorKey ?? GlobalKey<NavigatorState>());
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

  void _addNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    if (has<dynamic>(GlobalKey<NavigatorState>)) return;

    (this as ServiceRegistry).register<GlobalKey<NavigatorState>>(
      (p) => navigatorKey,
      const Service(
        exposeAs: GlobalKey<NavigatorState>,
        lifetime: ServiceLifetime.singleton,
      ),
    );
  }
}
