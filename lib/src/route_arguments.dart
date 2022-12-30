/// A helper class which can be injected to routes.
class RouteArguments {
  /// The variables from the path.
  final Map<String, String> pathVariables;

  /// The variables from the query.
  final Map<String, String> queryParameters;

  /// RouteArguments constructor
  RouteArguments(this.pathVariables, this.queryParameters);
}
