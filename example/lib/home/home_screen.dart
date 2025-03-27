import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/material.dart';

@Service(lifetime: ServiceLifetime.transient)
class HomeScreen extends StatelessWidget {
  final Routing _routing;

  const HomeScreen(this._routing, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorator example'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Simple navigation'),
            subtitle: const Text('Navigate to /other'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _routing.go('/other');
            },
          ),
          ListTile(
            title: const Text('Path variables'),
            subtitle: const Text('Navigate to /variables/{type=path}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _routing.go('/variables/path');
            },
          ),
          ListTile(
            title: const Text('Query parameters'),
            subtitle: const Text('Navigate to /variables/{type=query}?foo=bar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _routing.go('/variables/query?foo=bar');
            },
          ),
          ListTile(
            title: const Text('With settings'),
            subtitle: const Text('Navigate to /variables/settings?query=foo'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _routing.go(
                '/variables/settings?foo=bar',
                state: {'argument': 'other'},
              );
            },
          ),
        ],
      ),
    );
  }
}
