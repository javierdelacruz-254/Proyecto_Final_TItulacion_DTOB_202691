import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lactaamor/features/auth/models/user_model.dart';
import 'package:lactaamor/features/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._auth, this._googleSignIn);

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
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel.fromFirebase(credential.user!);
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await _googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception("Error autenticando con Firebase");
    }

    return UserModel.fromFirebase(firebaseUser);
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<bool> checkActionCode(String oobCode) {
    // TODO: implement checkActionCode
    throw UnimplementedError();
  }

  @override
  Future<void> confirmReset({
    required String oobCode,
    required String newPassword,
  }) {
    // TODO: implement confirmReset
    throw UnimplementedError();
  }

  @override
  Future<void> sendResetLink(String email) {
    // TODO: implement sendResetLink
    throw UnimplementedError();
  }
}
