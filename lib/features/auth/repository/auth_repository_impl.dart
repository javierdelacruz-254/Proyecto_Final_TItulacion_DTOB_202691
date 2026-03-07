import 'package:firebase_auth/firebase_auth.dart';
import 'package:lactaamor/features/auth/models/user_model.dart';
import 'package:lactaamor/features/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().map(
      (user) => user != null ? UserModel.fromFirebase(user) : null,
    );
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    print('🔑 Firebase login con: $email');
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(
      '📌 Firebase user: ${credential.user?.uid}, ${credential.user?.email}',
    );
    return UserModel.fromFirebase(credential.user!);
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<bool> checkActionCode(String oobCode) async {
    try {
      final info = await _auth.verifyPasswordResetCode(oobCode);
      return info.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> confirmReset({
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      await _auth.confirmPasswordReset(code: oobCode, newPassword: newPassword);
    } catch (e) {
      throw Exception("Error confirmado nueva contraseña: $e");
    }
  }

  @override
  Future<void> sendResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Error enviando código de recuperacion: $e");
    }
  }

  @override
  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email ?? "");
    }
    return null;
  }
}
