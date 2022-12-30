/// Is thrown when curly are unbalanced.
class UnbalancedCurlyBracesException implements Exception {
  /// The exception message.
  final String message;

  /// Throw a [UnbalancedCurlyBracesException] for unbalanced curly braces in
  /// the [source] string.
  UnbalancedCurlyBracesException(String source)
      : message = 'Unbalanced curly braces in $source';

  @override
  String toString() => message;
}
