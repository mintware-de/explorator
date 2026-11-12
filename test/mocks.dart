import 'package:catalyst_builder_runtime/catalyst_builder_runtime.dart';
import 'package:explorator/explorator.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/annotations.dart';

export 'mocks.mocks.dart';

@GenerateMocks(
  [RouteProvider, RouteMatcher, NavigatorState, ServiceContainer],
  customMocks: [MockSpec<GlobalKey<NavigatorState>>(as: #MockNavigatorKey)],
)
void main() {}
