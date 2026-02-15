import 'package:lactaamor/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);

  Future<User> register(User user, String password);

  Future<void> logout();
}
