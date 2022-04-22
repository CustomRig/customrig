abstract class AuthRepository {
  Future<String?> logIn(String email, String password);
  Future<String?> signUp(String email, String password);
}
