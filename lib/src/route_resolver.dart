import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';

/// The RouteResolver is used to resolve [Route]s from [RouteSettings].
/// All possible routes are provided by the [RouteProvider]s which are injected
/// by the routeProvider tag.
@Service()
class RouteResolver {
  final RouteBuilder _routeBuilder;
  final AbstractServiceContainer _serviceContainer;
  final RouteMatcher _routeMatcher;

  /// RouteResolver constructor.
  RouteResolver(
    this._routeMatcher,
    this._routeBuilder,
    this._serviceContainer,
  );

  /// Resolve a route for the given [settings].
  Route<dynamic>? resolveRoute(RouteSettings settings) {
    if (settings.name == null) {
      return null;
    }

    var uri = Uri.parse(settings.name!);
    var routeName = Uri.decodeFull(uri.path);

    var route = _routeMatcher.match(routeName);
    if (route == null) {
      return null;
    }

    var subProvider = _createSubProvider(
      route,
      routeName,
      uri.queryParameters,
      settings,
    );

    var widget = route.builder(subProvider);
    return _routeBuilder.build(widget, settings);
  }

  /// Creates a enhanced service provider which contains additional services:
  /// [RouteArguments] The arguments for the route which was resolved.
  ///                  This contains query parameters and path variables
  /// [RouteSettings]  The [RouteSettings] for the resolved route.
  AbstractServiceContainer _createSubProvider(
    RegisteredRoute route,
    String routeName,
    Map<String, String> queryParameters,
    RouteSettings settings,
  ) {
    var subContainer = _serviceContainer;
    var pathVariables = _getPathVariables(route.expression, routeName);
    return subContainer.enhance(
      services: [
        LazyServiceDescriptor<RouteArguments>(
          (p) => RouteArguments(routeName, pathVariables, queryParameters),
          const Service(
            lifetime: ServiceLifetime.transient,
            exposeAs: RouteArguments,
          ),
        ),
        LazyServiceDescriptor<RouteSettings>(
          (p) => settings,
          const Service(
            lifetime: ServiceLifetime.transient,
            exposeAs: RouteSettings,
          ),
        )
      ],
    );
  }

  Map<String, String> _getPathVariables(RegExp regExp, String routeName) {
    var match = regExp.allMatches(routeName).first;

    return Map.fromEntries(match.groupNames.map(
      (e) => MapEntry(e, match.namedGroup(e) ?? ''),
    )).cast<String, String>();
  }
}
