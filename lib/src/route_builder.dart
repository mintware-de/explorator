import 'package:flutter/widgets.dart';

abstract class RouteBuilder {
  Route build(WidgetBuilder builder, RouteSettings settings);
}
