## 1.1.0
Features:
- Added the `RouteProvider.tag` constant to reduce magic symbols.
- Added a ServiceProvider extension for registering the explorator services.
- Added a `GlobalKey<NavigatorState>` to the ServiceProvider.
- Added a `Routing` class. This class simplifies the routing without a BuildContext.
- Added the `path` to the `RouteArguments` class.

Changes:
- Changed the type of `RegisteredRoute.builder` to `ServiceFactory<WidgetBuilder>`

## 1.0.0

Initial release
