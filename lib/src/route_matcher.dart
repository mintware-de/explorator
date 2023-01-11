import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';

/// The RouteMatcher is used to match raw paths (/books/1234) against the
/// registered routes.
@Service()
class RouteMatcher {
  final List<RegisteredRoute> _allRoutes = [];

  /// Creates a new Route Matcher.
  /// The known routes are provided by the [routeProviders].
  RouteMatcher(
    @Inject(tag: RouteProvider.tag) List<RouteProvider> routeProviders,
  ) {
    for (var provider in routeProviders) {
      _allRoutes.addAll(provider.routes);
    }
  }

  /// Returns the route that matches against the path.
  RegisteredRoute? match(String path) {
    return _allRoutes.cast<RegisteredRoute?>().firstWhere(
          (route) => route!.expression.hasMatch(path),
          orElse: () => null,
        );
  }
}
