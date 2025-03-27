import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/material.dart';

@Service(lifetime: ServiceLifetime.transient)
class SplashScreen extends StatelessWidget {
  final Routing _routing;

  SplashScreen(this._routing, {super.key}) {
    Future.delayed(const Duration(seconds: 3), () {
      _routing.replace('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('Splash Screen, wait 3 seconds'),
      ),
    );
  }
}
