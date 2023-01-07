// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';

// class User extends Equatable {
//   final String name;
//   final int age;

//   User({required this.name, required this.age});

//   @override
//   List<Object?> get props => [name, age];

//   User copyWith({
//     String? name,
//     int? age,
//   }) {
//     return User(
//       name: name ?? this.name,
//       age: age ?? this.age,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'age': age,
//     };
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       age: json['age'] ?? '',
//       name: json['name'] ?? '',
//     );
//   }
// }
