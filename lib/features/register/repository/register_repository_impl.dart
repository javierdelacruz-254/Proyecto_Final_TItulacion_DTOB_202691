import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  RegisterRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> saveRegistroCompleto({
    required RegistroBasicoModel registroBasico,
    required PerfilMaternoModel perfilMaterno,
    PerfilMedicoModel? perfilMedico,
    EmbarazoActualModel? embarazoActual,
    DatosBebeModel? datosBebe,

    required String password,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: registroBasico.email,
      password: password,
    );

    final uid = credential.user!.uid;

    await firestore.collection('users').doc(uid).set({
      ...registroBasico.toFirestore(),
      'uid': uid,
      'perfilMaterno': perfilMaterno.toFirestore(),
      if (perfilMedico != null) 'perfilMedico': perfilMedico.toFirestore(),
      if (embarazoActual != null)
        'embarazoActual': embarazoActual.toFirestore(),
      if (datosBebe != null) 'datosBebe': datosBebe.toFirestore(),

      'status': 1,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<bool> checkEmailInStore(String email) async {
    final snapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}
