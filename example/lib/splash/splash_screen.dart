import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:flutter/material.dart';

@Service(lifetime: ServiceLifetime.transient)
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
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
