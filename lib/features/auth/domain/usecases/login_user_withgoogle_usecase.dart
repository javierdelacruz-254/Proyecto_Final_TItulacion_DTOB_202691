import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class LoginUserWithgoogleUsecase {
  final AuthRepository authRepository;

  LoginUserWithgoogleUsecase(this.authRepository);

  Future<UserEntity> call() {
    return authRepository.loginWithGoogle();
  }
}
