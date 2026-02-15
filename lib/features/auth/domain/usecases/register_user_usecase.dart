import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUsecase {
  final AuthRepository authRepository;

  RegisterUserUsecase(this.authRepository);

  Future<User> call(User user, String password) {
    return authRepository.register(user, password);
  }
}
