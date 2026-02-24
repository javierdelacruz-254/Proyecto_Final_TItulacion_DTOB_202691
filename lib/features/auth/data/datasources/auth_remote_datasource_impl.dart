import 'package:google_sign_in/google_sign_in.dart';
import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lactaamor/features/auth/data/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDatasourceImpl(this.auth, this.firestore, this._googleSignIn);

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc = await firestore
        .collection("users")
        .doc(credential.user!.uid)
        .get();

    if (!doc.exists || doc.data() == null) {
      throw Exception(
        "No se encontraron datos del usuario en la base de datos",
      );
    }
    return UserModel.fromFirestoreUserModel(doc.data()!);
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<UserModel> registerUser(UserModel usuario, String password) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: usuario.email ?? '',
      password: password,
    );

    final newUser = usuario.copyWith(uid: credential.user!.uid);

    await firestore
        .collection("users")
        .doc(newUser.uid)
        .set(newUser.toFirestore());

    return newUser;
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await _googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await auth.signInWithCredential(credential);

    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception("Error autenticando con Firebase");
    }

    return UserModel.fromFirebaseUser(firebaseUser);
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
