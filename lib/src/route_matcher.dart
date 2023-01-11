import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';

class RouteMatcher {
  RouteMatcher(List<RouteProvider> providers);

  RegisteredRoute? match(String path) {
    if (path == '/hello') {
      return RegisteredRoute(
        path: 'path',
        builder: (p) => (ctx) => Container(),
      );
    }
    return null;
  }
}
