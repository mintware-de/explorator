import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:explorator_example/home/home_screen.dart';

@Service(tags: [#routeProvider])
class HomeRouteProvider implements RouteProvider {
  @override
  List<RegisteredRoute> get routes => [
        RegisteredRoute(
          path: '/home',
          builder: (provider) => (ctx) => provider.resolve<HomeScreen>(),
        ),
      ];
}
