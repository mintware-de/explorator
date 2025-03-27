import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:flutter/widgets.dart';

/// Provides logic for routing
@Service(exposeAs: Routing, lifetime: ServiceLifetime.singleton)
class Routing {
  final GlobalKey<NavigatorState> _navigatorKey;

  /// Creates a new routing instance.
  /// The [navigatorKey] is required for navigating without a BuildContext.
  Routing({
    required GlobalKey<NavigatorState> navigatorKey,
  }) : _navigatorKey = navigatorKey;

  /// Navigate to a new [route]. The [state] is passed as the route arguments.
  Future<T?> go<T extends Object?>(
    String route, {
    Object? state,
  }) {
    return _navigatorKey.currentState!.pushNamed<T?>(route, arguments: state);
  }

  /// Replace the current route with the new [route].
  /// The [state] is passed as the route arguments.
  /// [result] is used to resolve the Future of the current route.
  Future<T?> replace<T extends Object?, TO extends Object?>(
    String route, {
    Object? state,
    TO? result,
  }) {
    return _navigatorKey.currentState!.pushReplacementNamed<T?, TO?>(
      route,
      arguments: state,
      result: result,
    );
  }

  /// Navigate to the previous route.
  void goBack<T extends Object?>([T? result]) {
    _navigatorKey.currentState!.pop<T>(result);
  }
}
