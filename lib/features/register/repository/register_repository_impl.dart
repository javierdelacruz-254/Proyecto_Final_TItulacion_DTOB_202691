import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/estado_emocional_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/perfil_obstetrico_model.dart';
import 'package:lactaamor/features/register/models/recien_nacido_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/models/senales_peligro_model.dart';
import 'package:lactaamor/features/register/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  RegisterRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> saveRegistroCompleto({
    DatosBebeModel? datosBebe,
    EmbarazoActualModel? embarazoActual, //
    required EstadoEmocionalModel estadoEmocional, //
    required PerfilMaternoModel perfilMaterno, //
    required PerfilMedicoModel perfilMedico, //
    required PerfilObstetricoModel perfilObstetrico,
    RecienNacidoModel? recienNacido, //
    required RegistroBasicoModel registroBasico, //
    required String password,
    required SenalesPeligroModel senalesPeligro, //
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: registroBasico.email!,
      password: password,
    );

    final uid = credential.user!.uid;

    await firestore.collection('users').doc(uid).set({
      ...registroBasico.toFirestore(),
      'uid': uid,
      if (datosBebe != null) 'datosBebe': datosBebe.toFirestore(),
      if (embarazoActual != null)
        'embarazoActual': embarazoActual.toFirestore(),
      'estadoEmocional': estadoEmocional.toFirestore(),
      'perfilMaterno': perfilMaterno.toFirestore(),
      'perfilMedico': perfilMedico.toFirestore(),
      'perfilObstetrico': perfilObstetrico.toFirestore(),
      if (recienNacido != null) 'recienNacido': recienNacido.toFirestore(),
      'senalesPeligro': senalesPeligro.toFirestore(),
      'status': 1,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
