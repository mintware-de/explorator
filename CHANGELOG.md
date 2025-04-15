## 2.0.0-rc.1

### Breaking Changes

- `catalyst_builder: ^5.0.0-rc.1` is required

## 2.0.0-dev.1

### Breaking Changes

- `catalyst_builder: ^5.0.0-dev.1` is required
- Configuration has changed. Take a look in [UPGRADE.md](UPGRADE.md) for guidance.

## 1.2.0

Changes:
- Add support for `catalyst_builder: ^4.0.0`

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
