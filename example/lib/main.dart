import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'main.catalyst_builder.g.dart';

@GenerateServiceProvider()
// The ServiceMap is required for wiring the  RouteBuilder. Replace it with your own if necessary.
@ServiceMap(services: {
  MaterialRouteBuilder: Service(exposeAs: RouteBuilder),
})
void main() {
  setPathUrlStrategy();

  /// Create an instance of the service provider
  var provider = DefaultServiceProvider();

  /// Register the provider itself
  provider.register(
    (p) => provider,
    const Service(
      exposeAs: ServiceProvider,
      lifetime: ServiceLifetime.singleton,
    ),
  );

  /// boot the provider
  provider.boot();

  /// Run the app
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
      // Set the initial route.
      initialRoute: '/',
      // Use the RouteResolver for generating routes
      onGenerateRoute: _provider.resolve<RouteResolver>().resolveRoute,
    );
  }
}
