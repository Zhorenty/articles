import 'package:flutter/material.dart';
import 'package:new_udemy_course/calculator.dart';
import 'package:new_udemy_course/operations.dart';
import 'package:new_udemy_course/operations_widget.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculator = Calculator();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Calculator'), Icon(Icons.calculate)],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              OperationsWidget(
                operations: Operations.add,
                calculator: calculator,
                operationName: 'Add',
              ),
              const Divider(),
              OperationsWidget(
                operations: Operations.substract,
                calculator: calculator,
                operationName: 'Substract',
              ),
              const Divider(),
              OperationsWidget(
                operations: Operations.multiply,
                calculator: calculator,
                operationName: 'multiply',
              ),
              const Divider(),
              OperationsWidget(
                operations: Operations.divide,
                calculator: calculator,
                operationName: 'divide',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
