import 'package:chat/repositories/models/user_model.dart';

abstract class AuthenticationRepository {
  bool get isAuthenticated;

  Future resetPassword(String email);

  Future<UserModel?> signin(
    String email,
    String password,
  );

  Future<UserModel?> signup(
    String email,
    String password,
    String affiliateId,
  );

  Future<void> logout();
}
