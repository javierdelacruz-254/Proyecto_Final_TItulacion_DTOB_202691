import 'package:lactaamor/features/auth/models/user_model.dart';

class AuthState {
  final bool isLoginLoading;
  final bool isLoading;
  final bool isResetLinkSent;
  final bool isCodeValid;
  final UserModel? user;
  final String? error;

  AuthState({
    this.isLoginLoading = false,
    this.isLoading = false,
    this.isResetLinkSent = false,
    this.isCodeValid = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoginLoading,
    bool? isGoogleLoading,
    bool? isLoading,
    bool? isResetLinkSent,
    bool? isCodeValid,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isLoading: isLoading ?? this.isLoading,
      isResetLinkSent: isResetLinkSent ?? this.isResetLinkSent,
      isCodeValid: isCodeValid ?? this.isCodeValid,
      user: user ?? this.user,
      error: error,
    );
  }
}
