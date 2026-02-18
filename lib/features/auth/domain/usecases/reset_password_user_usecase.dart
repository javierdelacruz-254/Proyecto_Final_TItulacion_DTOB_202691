import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUserUsecase {
  final AuthRepository authRepository;

  ResetPasswordUserUsecase(this.authRepository);

  Future<void> call(String email) {
    return authRepository.sendPasswordResetEmail(email);
  }
}
