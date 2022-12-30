import 'package:flutter/widgets.dart';
import 'package:explorator/explorator.dart';
import 'package:test/test.dart';

void main() {
  test('constructor', () {
    WidgetBuilder builder(p) => (ctx) => Container();
    var route = RegisteredRoute(
      path: '/hello',
      builder: builder,
    );
    expect(route.path, equals('/hello'));
    expect(route.builder, equals(builder));
    expect(route.expression.pattern, equals(r'^/hello$'));
  });
}
