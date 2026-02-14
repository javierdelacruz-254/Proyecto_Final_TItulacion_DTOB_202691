import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lactaamor/features/auth/domain/usecases/login_user.dart';
import 'package:lactaamor/features/auth/domain/usecases/logout_user.dart';
import 'package:lactaamor/features/auth/domain/usecases/register_user.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState({this.isLoading = false, this.error, this.isAuthenticated = false});

  AuthState copyWith({bool? isLoading, String? error, bool? isAuthenticated}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {});

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;

  AuthNotifier(this.loginUser, this.registerUser, this.logoutUser)
    : super(AuthState());

  Future<void> login(String email, String password) async {
    state = AuthState(isLoading: true);

    try {
      await loginUser(email: email, password: password);
      state = AuthState();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }
}
