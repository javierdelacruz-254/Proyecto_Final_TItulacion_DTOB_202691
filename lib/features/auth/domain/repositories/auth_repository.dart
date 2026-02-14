import 'package:lactaamor/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> register({
    required String nombres,
    required String apellidos,
    required String dni,
    required int edad,
    String? email,
    required String password,
    required String estadoEmbarazo,
    DateTime? fechaPartoEstimado,
    DateTime? fechaNacimientoBebe,
    int? semanasEmbarazo,
  });

  Future<AppUser> login({required String email, required String password});

  Future<void> logout();
}
