import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lactaamor/features/auth/data/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasourceImpl(this.auth, this.firestore);

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
}
