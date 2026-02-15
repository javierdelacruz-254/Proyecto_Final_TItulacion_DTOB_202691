import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepository authRepository;

  LoginUserUsecase(this.authRepository);

  Future<User> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
