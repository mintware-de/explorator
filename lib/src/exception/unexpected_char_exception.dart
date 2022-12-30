/// Is thrown when a unexpected character occurs.
class UnexpectedCharException implements Exception {
  /// The exception message.
  final String message;

  /// The unexpected character.
  final String char;

  /// Throw a UnexpectedCharException for an unexpected [char] at [index] inside
  /// the [source] string.
  UnexpectedCharException(String source, int index, this.char)
      : message = [
          "Unexpected '$char' at offset $index.",
          source,
          "^".padLeft(index + 1)
        ].join("\n");

  @override
  String toString() {
    return message;
  }
}
