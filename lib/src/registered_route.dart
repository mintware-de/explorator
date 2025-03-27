import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:flutter/widgets.dart';

import 'route_expression_builder.dart';

/// Describes a route
class RegisteredRoute {
  /// The route path.
  final String path;

  /// The RegExp.
  final RegExp expression;

  /// The builder for building the route content.
  final ServiceFactory<WidgetBuilder> builder;

  /// Route constructor.
  RegisteredRoute({
    required this.path,
    required this.builder,
  }) : expression = RouteExpressionBuilder.build(path);
}
