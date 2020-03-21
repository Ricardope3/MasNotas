
import 'package:mas_notas/models/user.dart';

abstract class RegisterRepository {
  Future<User> register(User user);
}

class RegisterUser extends RegisterRepository {
  @override
  Future<User> register(User user) {
    return Future.delayed(
        Duration(
          seconds: 1,
        ), () {
      return user;
    });
  }
}

