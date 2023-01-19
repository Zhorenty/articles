import 'package:flutter_test/flutter_test.dart';
import 'package:new_udemy_course/calculator.dart';

void main() {
  late Calculator calculator;
  setUp(() {
    calculator = Calculator();
  });
  //setUpAll(() => print('Runs BEFORE any test is executed'));

  // tearDown(() => print('Runs AFTER EVERY any test is executed'));
  // tearDownAll(() => print('Runs AFTER any test is executed'));

  group(
    'add',
    (() {
      test(
        'the calculator return 5 when adding 1 and 4',
        (() {
          final result = calculator.add(1, 4);
          expect(result, 5, reason: 'It should be exactly 5');
        }),
      );

      test(
        'Calculator creates a non null object',
        (() {
          expect(Calculator(), isNotNull);
        }),
      );

      test(
        'Calculator returns an double number',
        (() {
          final result = calculator.add(1, 4);
          expect(result, isA<double>());
        }),
      );
    }),
  );
  group(
    'substract',
    (() {
      test(
        'the calculator return 5 when substracting 6 and 1',
        (() {
          expect(calculator.substract(6, 1), 5,
              reason: 'It should be exactly 5');
        }),
      );
    }),
  );
  group(
    'multiply',
    (() {
      test(
        'the calculator return 25 when multiplying 5 and 5',
        (() {
          expect(calculator.multiply(5, 5), 25,
              reason: 'It should be exactly 25');
        }),
      );
    }),
  );
  group(
    'divide',
    (() {
      test(
        'the calculator return 1 when dividing 5 and 5',
        (() {
          expect(calculator.divide(5, 5), 1, reason: 'It should be exactly 1');
        }),
      );

      test(
        'the calculator throws an ArgumentError when dividing by zero',
        (() {
          expect(() => calculator.divide(10, 0), throwsArgumentError);
        }),
      );
    }),
  );

  group(
    'Future method',
    () {
      test('calculator was return 16, when the input is 4', () async {
        expect(await calculator.powerOfTwo(4), 16);
      });
    },
  );

  group('fibonacci sequence', () {
    test(
      'calculator was return [0, 1, 1, 2, 3, 5, 8, 13, 21]',
      () {
        expect(calculator.fibonacciSequence(),
            emitsInOrder([0, 1, 1, 2, 3, 5, 8, 13, 21]));
      },
    );
  });
}
