import 'package:explorator/explorator.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks.dart';

void main() {
  group('Routing', () {
    late Routing routing;
    late MockNavigatorKey mockNavigatorKey;
    late MockNavigatorState mockNavigatorState;

    setUp(() {
      mockNavigatorKey = MockNavigatorKey();
      mockNavigatorState = MockNavigatorState();
      when(mockNavigatorKey.currentState).thenReturn(mockNavigatorState);
      when(mockNavigatorState.pushNamed(any, arguments: anyNamed('arguments')))
          .thenAnswer((_) => Future<void>.value(null));
      when(mockNavigatorState.pushReplacementNamed(
        any,
        arguments: anyNamed('arguments'),
        result: anyNamed('result'),
      )).thenAnswer((_) => Future<void>.value(null));

      when(mockNavigatorState.pop(any)).thenReturn(null);

      routing = Routing(navigatorKey: mockNavigatorKey);
    });

    test('go without arguments', () {
      var result = routing.go('/foo').then((_) {});
      expect(result, const TypeMatcher<Future<void>>());
      verify(mockNavigatorState.pushNamed('/foo'));
    });

    test('go with arguments', () async {
      await routing.go('/foo', state: {'foo': 'bar'});
      verify(mockNavigatorState.pushNamed('/foo', arguments: {'foo': 'bar'}));
    });

    test('replace', () async {
      await routing.replace('/foo');
      verify(mockNavigatorState.pushReplacementNamed('/foo'));
    });

    test('replace with arguments and result', () async {
      await routing.replace('/foo', state: {'foo': 'bar'}, result: 1);
      verify(mockNavigatorState.pushReplacementNamed(
        '/foo',
        arguments: {'foo': 'bar'},
        result: 1,
      ));
    });

    test('goBack', () async {
      routing.goBack(2);
      verify(mockNavigatorState.pop(2));
    });
  });
}
