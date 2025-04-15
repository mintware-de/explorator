import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'main.catalyst_builder.plugin.g.dart';

@GenerateServiceContainerPlugin(
  pluginClassName: 'AppPlugin',
)
void main() {
  usePathUrlStrategy();

  // Create an instance of the service container
  var container = ServiceContainer();
  container
    ..useAppPlugin()
    // Extension method from the explorator package
    ..useExplorator()
    ..setupExplorator(
      routeBuilder: MaterialRouteBuilder(),
    )
    ..boot();

  // Run the app
  runApp(MyApp(container));
}

class MyApp extends StatelessWidget {
  /// Inject the provider
  final AbstractServiceContainer _container;

  const MyApp(this._container, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Use the navigator key
      navigatorKey: _container.resolve<GlobalKey<NavigatorState>>(),
      // Set the initial route.
      initialRoute: '/',
      // Use the RouteResolver for generating routes
      onGenerateRoute: _container.resolve<RouteResolver>().resolveRoute,
    );
  }
}
