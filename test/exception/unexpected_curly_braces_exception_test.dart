import 'package:explorator/explorator.dart';
import 'package:test/test.dart';

void main() {
  test('inheritance', () {
    var ex = UnbalancedCurlyBracesException('foo');
    expect(ex, const TypeMatcher<Exception>());
  });

  test('toString', () {
    var ex = UnbalancedCurlyBracesException('foo');
    const message = 'Unbalanced curly braces in foo';
    expect(ex.message, equals(message.trim()));
    expect(ex.toString(), equals(message.trim()));
  });
}
