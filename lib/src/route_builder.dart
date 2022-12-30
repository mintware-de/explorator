import 'package:flutter/widgets.dart';

/// The RouteBuilder is used to create [Route]s.
abstract class RouteBuilder {
  /// This method returns a [Route] which lead to a screen that shows [Widget]
  /// built by the [builder].
  Route build(WidgetBuilder builder, RouteSettings settings);
}
