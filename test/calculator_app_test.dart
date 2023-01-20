import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_udemy_course/calculator.dart';
import 'package:new_udemy_course/main.dart';
import 'package:new_udemy_course/operations.dart';
import 'package:new_udemy_course/operations_widget.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });
  group(
    'calculator app',
    () {
      testWidgets('Render 4 widgets of type OperationsWidget', ((tester) async {
        //create the widget
        await tester.pumpWidget(const CalculatorApp());

        //create the Finders
        final listTileFinder = find.byType(OperationsWidget);

        //comparing finder w/ matcher
        expect(listTileFinder, findsAtLeastNWidgets(4));
      }));
    },
  );

  group('add', () {
    testWidgets('show result when gives 2 nubmers', (tester) async {
      await tester.pumpWidget(const CalculatorApp());

      final topTextFieldFinder = find.byKey(const Key('textField_top_Add'));
      final bottomTextFieldFinder =
          find.byKey(const Key('textField_bottom_Add'));

      await tester.enterText(topTextFieldFinder, '3');
      await tester.enterText(bottomTextFieldFinder, '7');

      final textResult = find.text('Result: 10.0');
      //await tester.pump
      await tester.pumpAndSettle();
      expect(textResult, findsOneWidget);
    });
  });

  group('OperationWidget', () {
    testWidgets(
      'Render 10 when 3 and 7 added',
      ((widgetTester) async {
        await widgetTester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: OperationsWidget(
                operations: Operations.add,
                calculator: calculator,
                operationName: 'Add'),
          ),
        ));

        await widgetTester.enterText(
            find.byKey(const Key('textField_bottom_Add')), '3');
        await widgetTester.enterText(
            find.byKey(const Key('textField_top_Add')), '7');

        await widgetTester.pumpAndSettle();
        expect(find.text('Result: 10.0'), findsOneWidget);
      }),
    );
  });
}
