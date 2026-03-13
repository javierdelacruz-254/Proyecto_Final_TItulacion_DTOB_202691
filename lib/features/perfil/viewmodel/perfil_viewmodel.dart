import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/repository/auth_repository.dart';
import 'package:lactaamor/features/auth/repository/auth_repository_impl.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:lactaamor/features/perfil/viewmodel/perfil_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

final perfilViewModelProvider =
    StateNotifierProvider<PerfilViewModel, PerfilState>(
  (ref) => PerfilViewModel(
    ref.read(authRepositoryProvider),
    ref,
  ),
);

class PerfilViewModel extends StateNotifier<PerfilState> {
  final AuthRepository _authRepository;
  final Ref _ref;

  PerfilViewModel(this._authRepository, this._ref)
      : super(const PerfilState());

  Future<void> updateName(String fullname) async {
    if (fullname.trim().isEmpty) {
      state = state.copyWith(error: 'El nombre no puede estar vacío');
      return;
    }

    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      await _authRepository.updateProfile(fullname: fullname.trim());

      // Actualizamos el authViewModel con el nuevo nombre
      await _ref.read(authViewModelProvider.notifier).updateProfile(
            fullname: fullname.trim(),
          );

      // Recargamos el perfil completo desde Firestore
      await _ref.read(homeViewModelProvider.notifier).loadUser();

      state = state.copyWith(
        isLoading: false,
        isSaved: true,
        successMessage: 'Nombre actualizado correctamente ✅',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _friendlyError(e.toString()),
      );
    }
  }

  Future<void> updateEmail(String newEmail, String currentPassword) async {
    if (newEmail.trim().isEmpty || currentPassword.trim().isEmpty) {
      state = state.copyWith(error: 'Completa todos los campos');
      return;
    }

    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      await _authRepository.updateEmail(newEmail.trim(), currentPassword);
      state = state.copyWith(
        isLoading: false,
        isSaved: true,
        successMessage: 'Te enviamos un correo de verificación 📧',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _friendlyError(e.toString()),
      );
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      state = state.copyWith(error: 'Completa todos los campos');
      return;
    }
    if (newPassword != confirmPassword) {
      state = state.copyWith(error: 'Las contraseñas no coinciden');
      return;
    }
    if (newPassword.length < 6) {
      state = state.copyWith(error: 'Mínimo 6 caracteres');
      return;
    }

    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      await _authRepository.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      state = state.copyWith(
        isLoading: false,
        isSaved: true,
        successMessage: 'Contraseña actualizada correctamente ✅',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _friendlyError(e.toString()),
      );
    }
  }

  void clearMessages() {
    state = state.copyWith(error: null, successMessage: null, isSaved: false);
  }

  String _friendlyError(String error) {
    if (error.contains('wrong-password') ||
        error.contains('invalid-credential')) {
      return 'Contraseña actual incorrecta';
    }
    if (error.contains('email-already-in-use')) return 'Este correo ya está en uso';
    if (error.contains('invalid-email')) return 'Formato de correo inválido';
    if (error.contains('requires-recent-login')) {
      return 'Por seguridad, cierra sesión y vuelve a ingresar';
    }
    if (error.contains('network-request-failed')) return 'Sin conexión a internet';
    return 'Ocurrió un error. Intenta de nuevo.';
  }
}