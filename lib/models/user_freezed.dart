import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_udemy_course/models/location.dart';

part 'user_freezed.freezed.dart';
part 'user_freezed.g.dart';

@freezed
class User with _$User {
  const User._();
  @JsonSerializable(explicitToJson: true)
  const factory User({
    required String name,
    @Default(30) int? age,
    required List<Location> locations,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String infoUser() {
    return 'My name $name, my age: $age';
  }
}

// class User {
//   final String name;
//   final int age;
//   User({
//     required this.name,
//     required this.age,
//   });
// }
