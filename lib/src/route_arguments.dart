/// A helper class which can be injected to routes.
class RouteArguments {
  /// The raw path of the activated route.
  /// For example /home/foo
  final String path;

  /// The variables from the path.
  final Map<String, String> pathVariables;

  /// The variables from the query.
  final Map<String, String> queryParameters;

  /// RouteArguments constructor
  RouteArguments(this.path, this.pathVariables, this.queryParameters);
}
