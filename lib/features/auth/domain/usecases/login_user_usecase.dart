import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepository authRepository;

  LoginUserUsecase(this.authRepository);

  Future<UserEntity> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
