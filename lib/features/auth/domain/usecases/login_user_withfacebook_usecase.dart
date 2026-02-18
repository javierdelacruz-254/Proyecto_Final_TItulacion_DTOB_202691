import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class LoginUserWithfacebookUsecase {
  final AuthRepository authRepository;

  LoginUserWithfacebookUsecase(this.authRepository);

  Future<User> call() {
    return authRepository.loginWithFacebook();
  }
}
