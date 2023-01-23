import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_udemy_course/api/user_remote.dart';
import 'package:new_udemy_course/models/user.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;

  setUp((() {
    mockDio = MockDio();
  }));

  test('get user test(success)', () async {
    //Arrange
    when(() => mockDio.get('https://reqres.in/api/users/2'))
        .thenAnswer((_) async {
      return Future.value(Response<dynamic>(
        requestOptions: RequestOptions(path: 'https://reqres.in/api/users/2'),
        statusCode: 200,
        data: {
          "data": {
            "id": 2,
            "email": "janet.weaver@reqres.in",
            "first_name": "Janet",
            "last_name": "Weaver",
            "avatar": "https://reqres.in/img/faces/2-image.jpg"
          },
          "support": {
            "url": "https://reqres.in/#support-heading",
            "text":
                "To keep ReqRes free, contributions towards server costs are appreciated!"
          }
        },
      ));
    });

    // Act
    User? user = await UserRemoteRepository(dio: mockDio).getUser(2);

    // Assert
    expect(user, isNotNull);
    expect(user?.id, equals(2));
    expect(user?.name, equals('Janet Weaver'));
  });

  test('Get user test (Failure)', () async {
    when(() => MockDio().get('https://reqres.in/api/users/23'))
        .thenAnswer((_) async {
      return Future.value(Response<dynamic>(
        requestOptions: RequestOptions(path: 'https://reqres.in/api/users/23'),
        statusCode: 404,
        data: {},
      ));
    });

    User? user = await UserRemoteRepository(dio: mockDio).getUser(2);
    expect(user, isNull);
  });
}
