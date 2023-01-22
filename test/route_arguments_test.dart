import 'package:explorator/explorator.dart';
import 'package:test/test.dart';

void main() {
  test('constructor empty', () {
    var args = RouteArguments('', {}, {});
    expect(args.path.isEmpty, isTrue);
    expect(args.pathVariables.isEmpty, isTrue);
    expect(args.queryParameters.isEmpty, isTrue);
  });

  test('constructor not empty', () {
    var args = RouteArguments('/home', {'foo': 'bar'}, {'bar': 'baz'});
    expect(args.path, equals('/home'));
    expect(args.pathVariables, equals({'foo': 'bar'}));
    expect(args.queryParameters, equals({'bar': 'baz'}));
  });
}
