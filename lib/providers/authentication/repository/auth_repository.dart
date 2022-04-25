import 'package:customrig/model/user.dart';

abstract class AuthRepository {
  Future<User?> logIn(String email, String password);
  Future<User?> signUp(String email, String password);
}
