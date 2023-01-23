import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_udemy_course/api/user_local.dart';
import 'package:new_udemy_course/models/user.dart';
import 'package:new_udemy_course/repo_interface/i_user_repo.dart';

class MockDio extends Mock with Dio {}

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  test('get local user (success)', () async {
    LocalUserRepository localUserRepository = LocalUserRepository();

    User? user = await localUserRepository.getUser(12);

    expect(localUserRepository, isA<IUserRepository>());
    expect(user?.id, equals(12));
  });
}
