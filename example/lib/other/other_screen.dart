import 'package:catalyst_builder_runtime/catalyst_builder_runtime.dart';
import 'package:material_ui/material_ui.dart';

@Service()
class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Other')),
      body: const Center(child: Text('Other screen')),
    );
  }
}
