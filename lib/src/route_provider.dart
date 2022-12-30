import 'registered_route.dart';

/// This interface describe a object that can provide routes.
abstract class RouteProvider {
  /// Returns the existing routes.
  List<RegisteredRoute> get routes;
}
