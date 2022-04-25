import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/user.dart';
import 'package:customrig/providers/authentication/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> logIn(String email, String password) async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/user/login', data: {
      'email': email,
      'password': password,
    });
    // print("===========");
    // print(result);
    return User.fromJson(result.data);
  }

  @override
  Future<User?> signUp(String email, String password) async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/user/register', data: {
      'email': email,
      'password': password,
    });
    print(result.data);

    return User.fromJson(result.data);
  }
}
