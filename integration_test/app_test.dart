import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:new_udemy_course/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); //singleton

  group('add test', () {
    testWidgets('adding 20 and 58.2 and gets number from service',
        (tester) async {
      // Можно вызывать все приложение по виджету, переданного в метод runApp
      // await tester.pumpWidget(const CalculatorApp());

      // Или таким образом
      app.main();
      // wait for load data
      await tester.pumpAndSettle();

      //RESULT TEST
      final topTextFieldFinder = find.byKey(const Key('textField_top_Add'));
      final bottomTextFieldFinder =
          find.byKey(const Key('textField_bottom_Add'));

      await tester.enterText(topTextFieldFinder, '20');
      await Future.delayed(const Duration(seconds: 1));

      await tester.enterText(bottomTextFieldFinder, '58.2');
      await Future.delayed(const Duration(seconds: 2));

      final textResultFinder = find.text('Result: 78.2');
      await tester.pump();

      expect(textResultFinder, findsOneWidget);

      //BUTTON TAP W/ RESULT TESTING
      final elevatedButtonFinder = find.byKey(const Key('elevated_button_Add'));

      await tester.tap(elevatedButtonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      //в actual - finder, в matcher - finds...
      expect(find.textContaining('78 is the'), findsOneWidget);
      await Future.delayed(const Duration(seconds: 5));
    });
  });
}
