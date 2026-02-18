import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/login_user_withfacebook_usecase.dart';
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
    ref.read(loginWithFacebookProvider),
    ref.read(resetPasswordProvider),
  );
});

enum AuthStatus { initial, loading, authenticated, error }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? message;

  const AuthState({this.status = AuthStatus.initial, this.user, this.message});

  AuthState copyWith({AuthStatus? status, User? user, String? message}) {
    return AuthState(
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
  final LoginUserWithfacebookUsecase loginUserWithfacebookUsecase;
  final ResetPasswordUserUsecase resetPasswordUserUsecase;

  AuthNotifier(
    this.loginUserUsecase,
    this.registerUserUsecase,
    this.logoutUserUsecase,
    this.loginUserWithgoogleUsecase,
    this.loginUserWithfacebookUsecase,
    this.resetPasswordUserUsecase,
  ) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await loginUserUsecase(email, password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }

  Future<void> register(User user, String password) async {
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
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await loginUserWithgoogleUsecase();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        message: e.toString(),
      );
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await loginUserWithfacebookUsecase();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      await resetPasswordUserUsecase(email);

      state = state.copyWith(
        status: AuthStatus.initial,
        message: "Correo de recuperación enviado",
      );
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, message: e.toString());
    }
  }
}
