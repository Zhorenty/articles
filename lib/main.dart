import 'package:flutter/material.dart';
import 'package:new_udemy_course/value_key1.dart';
import 'package:new_udemy_course/value_key2.dart';
import 'package:new_udemy_course/value_key3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const ValueKeyExample3(),
    );
  }
}
