import '../models/user.dart';

abstract class IUserRepository {
  Future<User?> getUser(int id);
}
