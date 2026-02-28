import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lactaamor/features/auth/repository/auth_repository.dart';
import 'package:lactaamor/features/auth/repository/auth_repository_impl.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(FirebaseAuth.instance, GoogleSignIn.instance);
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

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoginLoading: true, error: null);

    try {
      final user = await authRepository.login(email: email, password: password);

      state = state.copyWith(isLoginLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoginLoading: false, error: e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isGoogleLoading: true);

    try {
      final user = await authRepository.loginWithGoogle();

      state = state.copyWith(isGoogleLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isGoogleLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    state = AuthState();
  }

  Future<void> sendResetLink(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await authRepository.sendResetLink(email);

      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkAction(String code) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final valid = await authRepository.checkActionCode(code);
      if (valid) {
        state = state.copyWith(isLoading: false, error: null);
      } else {
        state = state.copyWith(isLoading: false, error: "Codigo Incorrecto");
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
      state = state.copyWith(isLoading: false, error: "Contraseña actualizada");
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
