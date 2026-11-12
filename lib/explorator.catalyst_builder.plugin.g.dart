// ignore_for_file: prefer_relative_imports, public_member_api_docs, implementation_imports
// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:catalyst_builder_runtime/catalyst_builder_runtime.dart' as _i1;
import 'package:catalyst_builder_runtime/src/abstract_service_container.dart'
    as _i5;
import 'package:explorator/src/route_builder.dart' as _i4;
import 'package:explorator/src/route_matcher.dart' as _i2;
import 'package:explorator/src/route_resolver.dart' as _i3;
import 'package:explorator/src/routing.dart' as _i6;
import 'package:flutter/src/widgets/framework.dart' as _i7;
import 'package:flutter/src/widgets/navigator.dart' as _i8;

class Explorator implements _i1.ServiceContainerPlugin {
  @override
  Map<Type, _i1.ServiceDescriptor> provideKnownServices() {
    return <Type, _i1.ServiceDescriptor>{
      _i2.RouteMatcher: _i1.ServiceDescriptor(
        const _i1.Service(),
        (c) => _i2.RouteMatcher(c.resolveByTag(#routeProvider).cast()),
      ),
      _i3.RouteResolver: _i1.ServiceDescriptor(
        const _i1.Service(),
        (c) => _i3.RouteResolver(
          c.resolveOrGetParameter<_i2.RouteMatcher>(
            _i3.RouteResolver,
            '_routeMatcher',
          ),
          c.resolveOrGetParameter<_i4.RouteBuilder>(
            _i3.RouteResolver,
            '_routeBuilder',
          ),
          c.resolveOrGetParameter<_i5.AbstractServiceContainer>(
            _i3.RouteResolver,
            '_serviceContainer',
          ),
        ),
      ),
      _i6.Routing: _i1.ServiceDescriptor(
        const _i1.Service(exposeAs: _i6.Routing),
        (c) => _i6.Routing(
          navigatorKey: c
              .resolveOrGetParameter<_i7.GlobalKey<_i8.NavigatorState>>(
                _i6.Routing,
                'navigatorKey',
              ),
        ),
      ),
    };
  }

  @override
  Map<Type, Type> provideExposes() {
    return <Type, Type>{_i6.Routing: _i6.Routing};
  }

  @override
  List<Type> providePreloadedTypes() {
    return [];
  }

  @override
  Map<Symbol, List<Type>> provideServiceTags() {
    return <Symbol, List<Type>>{};
  }
}

extension ExploratorExtension on _i1.AbstractServiceContainer {
  void useExplorator() {
    applyPlugin(Explorator());
  }
}
