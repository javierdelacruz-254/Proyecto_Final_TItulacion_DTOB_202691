import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);

  Future<UserEntity> register(UserEntity user, String password);

  Future<void> logout();

  Future<UserEntity> loginWithGoogle();

  Future<void> sendResetLink(String email);

  Future<bool> checkActionCode(String oobCode);

  Future<void> confirmReset({
    required String oobCode,
    required String newPassword,
  });
}
