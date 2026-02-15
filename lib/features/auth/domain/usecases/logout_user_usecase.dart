import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class LogoutUserUsecase {
  final AuthRepository authRepository;

  LogoutUserUsecase(this.authRepository);

  Future<void> call() {
    return authRepository.logout();
  }
}
