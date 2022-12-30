import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:flutter/material.dart';

@Service(lifetime: ServiceLifetime.transient)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Navigator.of(context).pushNamed('/other');
            },
          ),
          ListTile(
            title: const Text('Path variables'),
            subtitle: const Text('Navigate to /variables/{type=path}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed('/variables/path');
            },
          ),
          ListTile(
            title: const Text('Query parameters'),
            subtitle: const Text('Navigate to /variables/{type=query}?foo=bar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed('/variables/query?foo=bar');
            },
          ),
          ListTile(
            title: const Text('With settings'),
            subtitle: const Text('Navigate to /variables/settings?query=foo'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/variables/settings?foo=bar',
                arguments: {'argument': 'other'},
              );
            },
          ),
        ],
      ),
    );
  }
}
