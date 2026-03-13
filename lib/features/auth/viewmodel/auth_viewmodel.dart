import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/models/user_model.dart';
import 'package:lactaamor/features/auth/repository/auth_repository.dart';
import 'package:lactaamor/features/auth/repository/auth_repository_impl.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(FirebaseAuth.instance);
});

final authViewModelProvider = StateNotifierProvider<AuthViewmodel, AuthState>((
  ref,
) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthViewmodel(authRepository);
});

class AuthViewmodel extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthViewmodel(this.authRepository) : super(AuthState());

  Future<void> login(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    print('⏳ Login iniciado para: $email');
    state = state.copyWith(isLoginLoading: true, error: null);

    try {
      final user = await authRepository.login(email: email, password: password);

      print('✅ Login exitoso: ${user.uid}, ${user.email}');

      await _saveFcmToken(user.uid);

      final prefs = await SharedPreferences.getInstance();

      if (rememberMe) {
        await saveEmail(email);
        await saveRememberMe(true);
        print('💾 Recordar usuario activado');
      } else {
        await prefs.remove('saved_email');
        await saveRememberMe(false);
        print('💾 Recordar usuario desactivado');
      }

      state = state.copyWith(isLoginLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoginLoading: false, error: e.toString());
      print('❌ Error en login: $e');
    }
  }

  Future<void> _saveFcmToken(String uid) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        // Guardar en Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'fcmToken': token,
          'lastTokenUpdate': FieldValue.serverTimestamp(),
        });
        print('🔑 FCM token guardado para usuario $uid: $token');
      }
    } catch (e) {
      print('❌ Error guardando FCM token: $e');
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    state = AuthState();
  }

  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('saved_email');
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("saved_email", email);
  }

  Future<void> saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("remember_me", value);
  }

  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("remember_me") ?? false;
  }

  Future<void> sendResetLink(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await authRepository.sendResetLink(email);

      state = state.copyWith(
        isLoading: false,
        isResetLinkSent: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkAction(String code) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final valid = await authRepository.checkActionCode(code);
      if (valid) {
        state = state.copyWith(
          isLoading: false,
          isCodeValid: true,
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isCodeValid: false,
          error: "Codigo Invalido",
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updatePassword(String code, String newPassword) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await authRepository.confirmReset(
        oobCode: code,
        newPassword: newPassword,
      );
      state = state.copyWith(
        isLoading: false,
        isResetLinkSent: false,
        error: "Contraseña actualizada correctamente",
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkLoggedIn() async {
    final currentUser = authRepository.getCurrentUser();
    if (currentUser != null) {
      state = state.copyWith(user: currentUser);
      await _saveFcmToken(currentUser.uid);
      print(
        "👤 Usuario cargado desde sesión persistente: ${currentUser.email}",
      );
    }
  }

  Future<void> updateProfile({String? fullname}) async {
  state = state.copyWith(isLoading: true, error: null);
  try {
    await authRepository.updateProfile(fullname: fullname);

    // Actualizamos el estado local con el nuevo nombre
    final updatedUser = UserModel(
      uid: state.user!.uid,
      email: state.user!.email,
      fullname: fullname ?? state.user?.fullname,
      photo: state.user?.photo,
    );

    state = state.copyWith(
      isLoading: false,
      user: updatedUser,
      error: null,
    );
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
  }
}

Future<void> updateEmail(String newEmail, String currentPassword) async {
  state = state.copyWith(isLoading: true, error: null);
  try {
    await authRepository.updateEmail(newEmail, currentPassword);
    state = state.copyWith(
      isLoading: false,
      // Email se actualiza tras verificación, avisamos al usuario
      error: null,
    );
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
  }
}

Future<void> changePassword({
  required String currentPassword,
  required String newPassword,
}) async {
  state = state.copyWith(isLoading: true, error: null);
  try {
    await authRepository.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    state = state.copyWith(isLoading: false, error: null);
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
  }
}

}
