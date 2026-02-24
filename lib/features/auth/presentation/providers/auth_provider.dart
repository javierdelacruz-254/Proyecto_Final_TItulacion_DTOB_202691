import 'package:firebase_auth/firebase_auth.dart';
import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/login_user_withgoogle_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/reset_password_user_usecase.dart';
import 'package:lactaamor/injection_container.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(loginUserProvider),
    ref.read(registerUserProvider),
    ref.read(logoutUserProvider),
    ref.read(loginWithGoogleProvider),
    ref.read(sendResetLinkProvider),
    ref.read(checkActionCodeProvider),
    ref.read(confirmResetProvider),
  );
});

enum AuthStatus { initial, loading, authenticated, error, codeSent, verified }

class AuthState {
  final bool isLoginLoading;
  final bool isGoogleLoading;
  final bool isRegisterLoading;
  final AuthStatus status;
  final UserEntity? user;
  final String? message;

  const AuthState({
    this.isLoginLoading = false,
    this.isGoogleLoading = false,
    this.isRegisterLoading = false,
    this.status = AuthStatus.initial,
    this.user,
    this.message,
  });

  AuthState copyWith({
    bool? isLoginLoading,
    bool? isGoogleLoading,
    bool? isRegisterLoading,
    AuthStatus? status,
    UserEntity? user,
    String? message,
  }) {
    return AuthState(
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      status: status ?? this.status,
      user: user ?? this.user,
      message: message,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUserUsecase loginUserUsecase;
  final RegisterUserUsecase registerUserUsecase;
  final LogoutUserUsecase logoutUserUsecase;
  final LoginUserWithgoogleUsecase loginUserWithgoogleUsecase;
  final SendResetLinkUseCase sendResetLinkUseCase;
  final CheckActionUseCase checkActionUseCase;
  final ConfirmResestUseCase confirmResestUseCase;

  AuthNotifier(
    this.loginUserUsecase,
    this.registerUserUsecase,
    this.logoutUserUsecase,
    this.loginUserWithgoogleUsecase,
    this.sendResetLinkUseCase,
    this.checkActionUseCase,
    this.confirmResestUseCase,
  ) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoginLoading: true);

    try {
      final user = await loginUserUsecase(email, password);
      state = state.copyWith(
        isLoginLoading: false,
        status: AuthStatus.authenticated,
        user: user,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        state = state.copyWith(
          isLoginLoading: false,
          status: AuthStatus.error,
          message: "Correo o contraseña incorrectos",
        );
      } else {
        state = state.copyWith(
          isLoginLoading: false,
          status: AuthStatus.error,
          message: "Error al iniciar sesión",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoginLoading: false,
        status: AuthStatus.error,
        message: "Error al iniciar sesión",
      );
    }
  }

  Future<void> register(UserEntity user, String password) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final newUser = await registerUserUsecase(user, password);
      state = state.copyWith(status: AuthStatus.authenticated, user: newUser);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }

  Future<void> logout() async {
    await logoutUserUsecase();
    state = const AuthState();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isGoogleLoading: true);

    try {
      final user = await loginUserWithgoogleUsecase();
      state = state.copyWith(
        isGoogleLoading: false,
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        isGoogleLoading: false,
        status: AuthStatus.error,
        message: e.toString(),
      );
    }
  }

  Future<void> sendLink(String email) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await sendResetLinkUseCase(email);
      state = state.copyWith(
        status: AuthStatus.codeSent,
        message: "Código enviado a $email",
      );
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }

  Future<void> checkAction(String code) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final valid = await checkActionUseCase(code);
      if (valid) {
        state = state.copyWith(status: AuthStatus.verified);
      } else {
        state = state.copyWith(
          status: AuthStatus.error,
          message: "Código incorrecto",
        );
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }

  Future<void> updatePassword(String code, String newPassword) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await confirmResestUseCase(code, newPassword);
      state = state.copyWith(
        status: AuthStatus.initial,
        message: "Contraseña actualizada",
      );
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }
}
