import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';

abstract class RegisterRepository {
  Future<void> saveRegistroCompleto({
    required RegistroBasicoModel registroBasico,
    required PerfilMaternoModel perfilMaterno,
    PerfilMedicoModel? perfilMedico,
    EmbarazoActualModel? embarazoActual,
    DatosBebeModel? datosBebe,
    required String password,
  });
}
