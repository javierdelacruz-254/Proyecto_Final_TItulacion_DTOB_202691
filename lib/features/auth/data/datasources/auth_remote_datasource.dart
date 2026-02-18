import 'package:lactaamor/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> registerUser(UserModel usuario, String password);

  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginWithFacebook();
  Future<void> sendPasswordResetEmail(String email);
}
