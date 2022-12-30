import 'package:catalyst_builder/catalyst_builder.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/material.dart';

@Service(lifetime: ServiceLifetime.transient)
class VariablesScreen extends StatefulWidget {
  final RouteArguments _arguments;

  final RouteSettings _settings;

  const VariablesScreen(this._arguments, this._settings, {Key? key})
      : super(key: key);

  @override
  State<VariablesScreen> createState() => _VariablesScreenState();
}

class _VariablesScreenState extends State<VariablesScreen> {
  @override
  Widget build(BuildContext context) {
    var text = '';

    if (widget._arguments.pathVariables.isNotEmpty) {
      text += 'Path variable:\n';
      text += widget._arguments.pathVariables.entries
          .map((e) => "${e.key}=${e.value}")
          .join('\n');
    }
    if (widget._arguments.queryParameters.isNotEmpty) {
      text += '\n\nQuery Parameters:\n';
      text += widget._arguments.queryParameters.entries
          .map((e) => "${e.key}=${e.value}")
          .join('\n');
    }

    if (widget._settings.arguments != null) {
      text += "\n\nRoute Arguments:\n";
      text += widget._settings.arguments.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Variables'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}
