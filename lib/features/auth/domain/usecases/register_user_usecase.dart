import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUsecase {
  final AuthRepository authRepository;

  RegisterUserUsecase(this.authRepository);

  Future<UserEntity> call(UserEntity user, String password) {
    return authRepository.register(user, password);
  }
}
