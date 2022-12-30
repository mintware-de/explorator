import 'package:explorator/explorator.dart';
import 'package:test/test.dart';

void main() {
  test('Simple without placeholders', () {
    var source = '/hello/world';
    var invalidSource = '/hello/world/bar';
    var target = r'^/hello/world$';

    var result = RouteExpressionBuilder.build(source);
    expect(result.pattern, equals(target));
    expect(result.hasMatch(source), isTrue);
    expect(result.hasMatch(invalidSource), isFalse);
  });

  test('Simple with placeholder', () {
    var source = '/hello/{name}';
    var target = r'^/hello/(?<name>([^/]+))$';

    var result = RouteExpressionBuilder.build(source);
    expect(result.pattern, equals(target));
    expect(result.hasMatch(source), isTrue);
  });

  test('Simple with placeholder and type', () {
    var source = r'/hello/{name:\w+}';
    var example = r'/hello/world';
    var target = r'^/hello/(?<name>(\w+))$';

    var result = RouteExpressionBuilder.build(source);
    expect(result.pattern, equals(target));
    expect(result.hasMatch(example), isTrue);
  });

  test('Should throw on unexpected }', () {
    var source = r'/hello/}name:\w+}';

    try {
      RouteExpressionBuilder.build(source);
      fail('Does not throw');
    } on UnexpectedCharException catch (e) {
      expect(e, const TypeMatcher<UnexpectedCharException>());
      expect(e.char, equals('}'));
    } catch (e) {
      fail(e.toString());
    }
  });

  test('Should throw on unexpected {', () {
    var source = r'/hello/{name:\w+{';

    try {
      RouteExpressionBuilder.build(source);
      fail('Does not throw');
    } on UnexpectedCharException catch (e) {
      expect(e, const TypeMatcher<UnexpectedCharException>());
      expect(e.char, equals('{'));
    } catch (e) {
      fail(e.toString());
    }
  });
  test('Should throw on unbalanced {}', () {
    var source = r'/hello/{name:\w+';

    try {
      RouteExpressionBuilder.build(source);
      fail('Does not throw');
    } on UnbalancedCurlyBracesException catch (e) {
      expect(e, const TypeMatcher<UnbalancedCurlyBracesException>());
    } catch (e) {
      fail(e.toString());
    }
  });
}
