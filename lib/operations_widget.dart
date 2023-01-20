import 'package:flutter/material.dart';
import 'package:new_udemy_course/calculator.dart';
import 'package:new_udemy_course/operations.dart';

class OperationsWidget extends StatefulWidget {
  final Operations operations;
  final Calculator calculator;
  final String operationName;
  const OperationsWidget({
    super.key,
    required this.operations,
    required this.calculator,
    required this.operationName,
  });

  @override
  State<OperationsWidget> createState() => _OperationsWidgetState();
}

class _OperationsWidgetState extends State<OperationsWidget> {
  final _topTextController = TextEditingController();
  final _bottomTextContoroller = TextEditingController();
  String _operationResult = '';
  String _resultAfterAnimation = '';

  late String _operationName;

  @override
  void initState() {
    _topTextController.addListener(_getResult);
    _bottomTextContoroller.addListener(_getResult);
    super.initState();
    _operationName = widget.operationName;
  }

  @override
  void dispose() {
    _topTextController.dispose();
    _bottomTextContoroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_operationName),
      leading: widget.operations.iconOperation,
      subtitle: Column(
        children: [
          TextField(
            key: Key('textField_top_$_operationName'),
            controller: _topTextController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter 1st number'),
          ),
          TextField(
            key: Key('textField_bottom_$_operationName'),
            controller: _bottomTextContoroller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter 2nd number'),
          ),
          const SizedBox(height: 20),
          AnimatedContainer(
            padding: const EdgeInsets.all(8),
            duration: const Duration(seconds: 1),
            onEnd: (() {
              setState(() {
                _resultAfterAnimation = _operationResult.toString();
              });
            }),
            color: _operationResult.isEmpty ? Colors.transparent : Colors.green,
            curve: Curves.easeInOut,
            child: Text(
              _resultAfterAnimation.isNotEmpty
                  ? 'Result: $_resultAfterAnimation'
                  : 'Result: ',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.end,
            ),
          )

          // Text(
          //   'Result: $_operationResult',
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
        ],
      ),
    );
  }

  //отвечает за результат, полученный с текстФилдов
  void _getResult() {
    try {
      final result = _calculate(double.tryParse(_topTextController.text)!,
          double.tryParse(_bottomTextContoroller.text)!);
      setState(() {
        _operationResult = result.toString();
      });
    } catch (e) {
      setState(() {
        _operationResult = '';
      });
    }
  }

  //отвечает за вызов методов из calculator.dart
  double _calculate(double top, double bottom) {
    double result;
    switch (widget.operations) {
      case Operations.add:
        result = widget.calculator.add(top, bottom);
        break;
      case Operations.substract:
        result = widget.calculator.substract(top, bottom);
        break;
      case Operations.multiply:
        result = widget.calculator.multiply(top, bottom);
        break;
      case Operations.divide:
        result = widget.calculator.divide(top, bottom);
        break;
    }
    return result;
  }
}
