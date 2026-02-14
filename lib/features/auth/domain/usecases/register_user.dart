import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future call({
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
  }) {
    return repository.register(
      nombres: nombres,
      apellidos: apellidos,
      dni: dni,
      edad: edad,
      password: password,
      estadoEmbarazo: estadoEmbarazo,
      fechaPartoEstimado: fechaPartoEstimado,
      fechaNacimientoBebe: fechaNacimientoBebe,
      semanasEmbarazo: semanasEmbarazo,
    );
  }
}
