import 'exception/unbalanced_curly_braces_exception.dart';
import 'exception/unexpected_char_exception.dart';

/// Provides functionality for converting route paths to expressions.
class RouteExpressionBuilder {
  final String _path;

  late int _index;
  late String _pattern;
  late bool _isInPlaceholder;
  late bool _hasExplicitType;
  late String _placeholder;
  late String _type;
  late String _char;
  late List<String> _characters;

  RouteExpressionBuilder._(this._path);

  /// Builds a RegExp from the [path].
  static RegExp build(String path) => RouteExpressionBuilder._(path)._build();

  RegExp _build() {
    _startBuild();

    for (_index = 0; _index < _characters.length; _index++) {
      _char = _characters[_index];
      if (_char == '{') {
        _visitOpenCurlyBrace();
      } else if (_char == '}') {
        _visitClosingCurlyBrace();
      } else if (_char == ':') {
        _visitColon();
      } else {
        _visitDefault();
      }
    }

    _finishBuild();

    return RegExp('^$_pattern\$');
  }

  void _startBuild() {
    _index = 0;
    _pattern = "";
    _isInPlaceholder = false;
    _hasExplicitType = false;
    _placeholder = "";
    _type = "";
    _characters = _path.split('');
    _char = "";
  }

  void _finishBuild() {
    if (_isInPlaceholder) {
      throw UnbalancedCurlyBracesException(_path);
    }
  }

  void _visitOpenCurlyBrace() {
    if (_isInPlaceholder) {
      _throwUnexpectedCharException();
    }
    _placeholder = "";
    _isInPlaceholder = true;
    _pattern += '(?<';
    _type = "[^/]+";
  }

  void _visitClosingCurlyBrace() {
    if (!_isInPlaceholder) {
      _throwUnexpectedCharException();
    }

    _pattern += '$_placeholder>($_type))';

    _isInPlaceholder = false;
    _hasExplicitType = false;
  }

  void _visitColon() {
    if (!_isInPlaceholder) {
      return;
    }
    _type = "";
    _hasExplicitType = true;
  }

  void _visitDefault() {
    if (_isInPlaceholder) {
      if (_hasExplicitType) {
        _type += _char;
      } else {
        _placeholder += _char;
      }
    } else {
      _pattern += RegExp.escape(_char);
    }
  }

  void _throwUnexpectedCharException() =>
      throw UnexpectedCharException(_path, _index, _char);
}
