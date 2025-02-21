import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'main.catalyst_builder.g.dart';

@GenerateServiceProvider(
    providerClassName: 'DefaultServiceProvider',
    includePackageDependencies: true
)
void main() {
  setPathUrlStrategy();

  // Create an instance of the service provider
  var provider = DefaultServiceProvider();
  provider
    // Extension method from the explorator package
    ..useExplorator(
      routeBuilder: MaterialRouteBuilder(),
    )
    ..boot();

  // Run the app
  runApp(MyApp(provider));
}

class MyApp extends StatelessWidget {
  /// Inject the provider
  final ServiceProvider _provider;

  const MyApp(this._provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Use the navigator key
      navigatorKey: _provider.resolve<GlobalKey<NavigatorState>>(),
      // Set the initial route.
      initialRoute: '/',
      // Use the RouteResolver for generating routes
      onGenerateRoute: _provider.resolve<RouteResolver>().resolveRoute,
    );
  }
}
