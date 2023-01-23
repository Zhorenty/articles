import 'package:new_udemy_course/models/user.dart';
import '../repo_interface/i_user_repo.dart';

class LocalUserRepository implements IUserRepository {
  @override
  Future<User?> getUser(int id) async {
    return User(id: id);
  }
}
