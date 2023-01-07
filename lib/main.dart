import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_udemy_course/models/user_freezed.dart';
import 'package:new_udemy_course/models/location.dart';

void main() {
  User userA = const User(
      name: 'User', age: 30, locations: [Location(zipcode: '4432342')]);
  print(userA.toJson());
  // User userB = const User(name: 'User', age: 30);

  // log(userA.hashCode.toString());
  // log(userB.hashCode.toString());

  // print(userA == userB);

  // // copyWith
  // final userCopyA = userA.copyWith(
  //   name: 'User A',
  // );

  // print('User A Copy: $userCopyA');
  // //serialization
  // final json = userA.toJson();
  // print('User A toJson: $json');
  // print('User A fromJson: ${User.fromJson(json) ');
}
