import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final doc = await firestore.collection('users').doc(uid).get();

    return UserModel.fromFirestore(doc.data()!, uid);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel> registerUser({
    required String nombres,
    required String apellidos,
    required String dni,
    required int edad,
    String? email,
    required String password,
    required String estadoEmbarazo,
    DateTime? fechaPartoEstimado,
    DateTime? fechaNacimientoBebe,
    int? semanasEmbarazo,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email ?? '',
      password: password,
    );

    final uid = credential.user!.uid;

    final userModel = UserModel(
      id: uid,
      nombres: nombres,
      apellidos: apellidos,
      dni: dni,
      edad: edad,
      email: email,
      estadoEmbarazo: estadoEmbarazo,
      fechaPartoEstimado: fechaPartoEstimado,
      fechaNacimientoBebe: fechaNacimientoBebe,
      semanasEmbarazo: semanasEmbarazo,
      estado: 'enabled',
    );

    await firestore.collection('users').doc(uid).set(userModel.toFirestore());
    return userModel;
  }
}
