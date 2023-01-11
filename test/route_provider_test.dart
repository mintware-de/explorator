import 'package:explorator/explorator.dart';
import 'package:test/test.dart';

void main() {
  test('Should have a constant with the tag', () {
    expect(RouteProvider.tag, equals(#routeProvider));
  });
}
