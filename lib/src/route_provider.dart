import 'registered_route.dart';

/// This interface describe a object that can provide routes.
abstract class RouteProvider {
  /// The tag for registering the route provider in catalyst_builder.
  static const tag = #routeProvider;

  /// Returns the existing routes.
  List<RegisteredRoute> get routes;
}
