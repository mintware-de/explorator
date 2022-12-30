import 'package:explorator/explorator.dart';
import 'package:test/test.dart';

void main() {
  test('inheritance', () {
    var ex = UnexpectedCharException('', 0, 'x');
    expect(ex, const TypeMatcher<Exception>());
    expect(ex.char, equals('x'));
  });

  test('toString', () {
    var ex = UnexpectedCharException('abc', 2, 'c');
    const message = """
Unexpected 'c' at offset 2.
abc
  ^
""";
    expect(ex.message, equals(message.trim()));
    expect(ex.char, equals('c'));
    expect(ex.toString(), equals(message.trim()));
  });
}
