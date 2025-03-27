import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:explorator_example/home/home_screen.dart';

@Service(tags: [RouteProvider.tag])
class HomeRouteProvider implements RouteProvider {
  @override
  List<RegisteredRoute> get routes => [
        RegisteredRoute(
          path: '/home',
          builder: (provider) => (ctx) => provider.resolve<HomeScreen>(),
        ),
      ];
}
