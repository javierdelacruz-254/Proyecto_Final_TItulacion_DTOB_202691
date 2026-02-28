import 'package:lactaamor/features/auth/models/user_model.dart';

class AuthState {
  final bool isLoginLoading;
  final bool isGoogleLoading;
  final bool isLoading;
  final UserModel? user;
  final String? error;

  AuthState({
    this.isLoginLoading = false,
    this.isGoogleLoading = false,
    this.isLoading = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoginLoading,
    bool? isGoogleLoading,
    bool? isLoading,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}
