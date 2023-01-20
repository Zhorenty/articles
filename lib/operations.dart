import 'package:flutter/material.dart';

enum Operations {
  add('Adding', Icon(Icons.add)),
  substract('Substract', Icon(Icons.remove)),
  multiply('Multiply', Icon(Icons.cancel_outlined)),
  divide('Division', Icon(Icons.architecture));

  final String descriptionOperation;
  final Icon iconOperation;

  const Operations(this.descriptionOperation, this.iconOperation);
}
