import 'package:lactaamor/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> registerUser({
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

  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<void> logout();
}
