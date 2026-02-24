import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class SendResetLinkUseCase {
  final AuthRepository authRepository;

  SendResetLinkUseCase(this.authRepository);

  Future<void> call(String email) async {
    await authRepository.sendResetLink(email);
  }
}

class CheckActionUseCase {
  final AuthRepository authRepository;

  CheckActionUseCase(this.authRepository);

  Future<bool> call(String oobCode) async {
    return await authRepository.checkActionCode(oobCode);
  }
}

class ConfirmResestUseCase {
  final AuthRepository authRepository;

  ConfirmResestUseCase(this.authRepository);

  Future<void> call(String oobCode, String newPassword) async {
    await authRepository.confirmReset(
      oobCode: oobCode,
      newPassword: newPassword,
    );
  }
}
