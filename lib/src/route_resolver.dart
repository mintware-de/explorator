import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';

/// The RouteResolver is used to resolve [Route]s from [RouteSettings].
/// All possible routes are provided by the [RouteProvider]s which are injected
/// by the routeProvider tag.
@Service()
class RouteResolver {
  final List<RouteProvider> _providers;
  final RouteBuilder _routeBuilder;
  final ServiceProvider _provider;
  final List<RegisteredRoute> _allRoutes = [];

  /// RouteResolver constructor.
  RouteResolver(
    @Inject(tag: #routeProvider) this._providers,
    this._routeBuilder,
    this._provider,
  ) {
    for (var provider in _providers) {
      _allRoutes.addAll(provider.routes);
    }
  }

  /// Resolve a route for the given [settings].
  Route<dynamic>? resolveRoute(RouteSettings settings) {
    var routeName = settings.name;

    if (routeName == null) {
      return null;
    }

    var uri = Uri.parse(routeName);
    routeName = Uri.decodeFull(uri.path);

    for (var route in _allRoutes) {
      if (route.expression.hasMatch(routeName)) {
        var pathVariables = _getPathVariables(route.expression, routeName);

        var subProvider = _createSubProvider(
          pathVariables,
          uri.queryParameters,
          settings,
        );

        var widget = route.builder(subProvider);
        return _routeBuilder.build(widget, settings);
      }
    }
    return null;
  }

  /// Creates a enhanced service provider which contains additional services:
  /// [RouteArguments] The arguments for the route which was resolved.
  ///                  This contains query parameters and path variables
  /// [RouteSettings]  The [RouteSettings] for the resolved route.
  ServiceProvider _createSubProvider(
    Map<String, String> pathVariables,
    Map<String, String> queryParameters,
    RouteSettings settings,
  ) {
    var subProvider = _provider;
    if (subProvider is EnhanceableProvider) {
      subProvider = (subProvider as EnhanceableProvider).enhance(
        services: [
          LazyServiceDescriptor<RouteArguments>(
            (p) => RouteArguments(pathVariables, queryParameters),
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
    return subProvider;
  }

  Map<String, String> _getPathVariables(RegExp regExp, String routeName) {
    var match = regExp.allMatches(routeName).first;

    return Map.fromEntries(match.groupNames.map(
      (e) => MapEntry(e, match.namedGroup(e) ?? ''),
    )).cast<String, String>();
  }
}
