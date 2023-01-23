import 'package:flutter_test/flutter_test.dart';
import 'package:new_udemy_course/models/user.dart';

void main() {
  group('User tests', () {
    User user = User();

    test('user has an id w/ type int', () {
      expect(user.id, isA<int>());
    });
    test('user has an String name', () {
      expect(user.name, isA<String>());
    });

    test('Default user id = 0, default name = no name', () {
      expect(user.id, equals(0));
      expect(user.name, 'No name');
    });
  });

  group('Custom user test', () {
    User user1 = User(id: 1);
    User user2 = User(name: 'Zhora');
    User user3 = User(id: 1, name: 'Zhora');

    test('param id is valid', () {
      expect(user1.id, 1);
      expect(user1.name, 'No name');
    });

    test('param name is valid', () {
      expect(user2.id, 0);
      expect(user2.name, 'Zhora');
    });

    test('all params are correct', () {
      expect(user3.id, 1);
      expect(user3.name, 'Zhora');
    });
  });
}
