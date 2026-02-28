import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/estado_emocional_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/perfil_obstetrico_model.dart';
import 'package:lactaamor/features/register/models/recien_nacido_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/models/senales_peligro_model.dart';

abstract class RegisterRepository {
  Future<void> saveRegistroCompleto({
    DatosBebeModel? datosBebe,
    EmbarazoActualModel? embarazoActual,
    required EstadoEmocionalModel estadoEmocional,
    required PerfilMaternoModel perfilMaterno,
    required PerfilMedicoModel perfilMedico,
    required PerfilObstetricoModel perfilObstetrico,
    RecienNacidoModel? recienNacido,
    required RegistroBasicoModel registroBasico,
    required String password,
    required SenalesPeligroModel senalesPeligro,
  });
}
