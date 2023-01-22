## Installation

- Follow the setup steps for [catalyst_builder](https://pub.dev/packages/catalyst_builder).
- Follow the setup steps for [explorator](https://pub.dev/packages/explorator/install).

### Update the build.yaml

Make sure that you set includePackageDependencies to true in the build.yaml:

```yaml
# build.yaml
targets:
  $default:
    auto_apply_builders: true
    builders:
      catalyst_builder|buildServiceProvider:
        options:
          providerClassName: 'DefaultServiceProvider'
          includePackageDependencies: true
```

### Register the RouteResolver

```dart
@GenerateServiceProvider()
void main() {
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
      initialRoute: '/home/HelloFlutter',
      // Use the RouteResolver for generating routes
      onGenerateRoute: _provider
          .resolve<RouteResolver>()
          .resolveRoute,
    );
  }
}

```

## Usage

After you set up the routing, you can register routes.

```dart
/// Create a class that implements the RouteProvider and add the @Service annotation with a tag.
@Service(tags: [RouteProvider.tag])
class HomeRouteProvider implements RouteProvider {
  @override
  List<RegisteredRoute> get routes =>
      [
        // Return your routes
        RegisteredRoute(
          path: r'/home/{name}',
          // The builder should return a function that accepts a provider (ServiceProvider from above)
          // and returns a WidgetBuilder. Since we have the provider, we can use DI to get the instance
          // of our widget 🙌.
          builder: (provider) => (ctx) => provider.resolve<MyHomePage>(),
        )
      ];
}

/// Decorate your Widget with the Service Annotation.
/// ServiceLifetime.transient is required to create always a fresh instance of this widget.
@Service(lifetime: ServiceLifetime.transient)
class MyHomePage extends StatefulWidget {
  /// RouteArguments contains the parameters and other settings of the route.
  final RouteArguments arguments;

  const MyHomePage(this.arguments, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        /// Access the name variable from the route. For example "HelloFlutter"
        title: Text(widget.arguments.pathVariables['name'] ?? 'Missing name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

To navigate between routes you can use the [`Routing`](../lib/src/routing.dart) class or the default `Navigator.of(context).xxxNamed` methods.

You find a full example in the [example](../example) directory.

## Route variables

As you can see in the example above, you can specify variables in the route. The format is `{name}`
or `{name:REGEXP}` where REGEXP is a regular expression string.

| Route                | Valid                            | Invalid                   | Path variables (valid example) |
|----------------------|----------------------------------|---------------------------|--------------------------------|
| `/home`              | `/home`                          | `/home/foo`               | -                              |
| `/home/{name}`       | `/home/foo`, `/home/bar`         | `/home/foo/bar`           | name=foo, name=bar             |
| `/home/{name:.+}`    | `/home/foo`, `/home/foo/bar`     | `/other`                  | name=foo, name=foo/bar         |
| `/user/{userId:\d}`  | `/user/1`, `/user/2`             | `/user/12`, `/user/admin` | userId=1, userId=2             |
| `/user/{userId:\d+}` | `/user/1`, `/user/2`, `/user/12` | `/user/admin`             | userId=1, userId=2             |

Query parameters are supported in all examples above.

You can access path variables and query parameters when injecting the `RouteArguments` object.

## Dev / Prod

While you develop your app, you can use the following command to watch for changes and update the
routing / ServiceProvider automatically

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

When building for production you can use this command before running `flutter build`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## How does it work?
Check out the "[under the hood](./under-the-hood.md)" doc.