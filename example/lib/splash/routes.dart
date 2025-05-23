import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:explorator_example/splash/splash_screen.dart';

@Service(tags: [RouteProvider.tag])
class SplashRouteProvider implements RouteProvider {
  @override
  List<RegisteredRoute> get routes => [
        RegisteredRoute(
          path: '/',
          builder: (provider) => (ctx) => provider.resolve<SplashScreen>(),
        ),
      ];
}
