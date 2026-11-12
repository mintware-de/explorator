import 'package:material_ui/material_ui.dart';

import 'route_builder.dart';

/// Material implementation of the RouteBuilder.
class MaterialRouteBuilder implements RouteBuilder {
  @override
  Route build(WidgetBuilder builder, RouteSettings settings) {
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
