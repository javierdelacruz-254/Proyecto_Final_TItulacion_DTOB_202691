import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class LoginUserWithgoogleUsecase {
  final AuthRepository authRepository;

  LoginUserWithgoogleUsecase(this.authRepository);

  Future<User> call() {
    return authRepository.loginWithGoogle();
  }
}
