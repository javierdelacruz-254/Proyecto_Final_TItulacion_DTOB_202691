import 'package:lactaamor/features/auth/models/user_model.dart';

abstract class AuthRepository {
  //Escuchar cambios del model
  Stream<UserModel?> authStateChanges();

  //Funcion de login de usuario
  Future<UserModel> login({required String email, required String password});

  //Funcion de cerrar sesion de usuario
  Future<void> logout();

  //Funcion para enviar a email el codigo de verificacion
  Future<void> sendResetLink(String email);

  //Funcion para verificar si es el codigo correcto
  Future<bool> checkActionCode(String oobCode);

  //Funcion para confirmar la nueva contraseña junto con el codigo de verificacion
  Future<void> confirmReset({
    required String oobCode,
    required String newPassword,
  });

  //Obtener el usuario activo en sesion
  UserModel? getCurrentUser();
}
