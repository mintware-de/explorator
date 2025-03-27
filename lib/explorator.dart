library explorator;

import 'package:catalyst_builder_contracts/catalyst_builder_contracts.dart';

export 'explorator.catalyst_builder.plugin.g.dart';
export 'src/exception/unbalanced_curly_braces_exception.dart';
export 'src/exception/unexpected_char_exception.dart';
export 'src/extensions.dart';
export 'src/material_route_builder.dart';
export 'src/registered_route.dart';
export 'src/route_arguments.dart';
export 'src/route_builder.dart';
export 'src/route_expression_builder.dart';
export 'src/route_matcher.dart';
export 'src/route_provider.dart';
export 'src/route_resolver.dart';
export 'src/routing.dart';

@GenerateServiceProviderPlugin(pluginClassName: 'Explorator')
void _() {} // ignore: unused_element
