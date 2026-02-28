import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/estado_emocional_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/perfil_obstetrico_model.dart';
import 'package:lactaamor/features/register/models/recien_nacido_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/models/senales_peligro_model.dart';

class RegisterState {
  final int currentStep;
  final bool isLoading;
  final String? error;
  final String? password;
  final bool isSuccess;

  final RegistroBasicoModel? registroBasicoModel;
  final PerfilMaternoModel? perfilMaternoModel;
  final PerfilObstetricoModel? perfilObstetricoModel;
  final PerfilMedicoModel? perfilMedicoModel;
  final EmbarazoActualModel? embarazoActualModel;
  final SenalesPeligroModel? senalesPeligroModel;
  final RecienNacidoModel? recienNacidoModel;
  final DatosBebeModel? datosBebeModel;
  final EstadoEmocionalModel? estadoEmocionalModel;

  final bool haDadoLuz;

  RegisterState({
    this.currentStep = 0,
    this.isLoading = false,
    this.error,
    this.password,
    this.isSuccess = false,
    this.registroBasicoModel,
    this.perfilMaternoModel,
    this.perfilObstetricoModel,
    this.perfilMedicoModel,
    this.embarazoActualModel,
    this.senalesPeligroModel,
    this.recienNacidoModel,
    this.datosBebeModel,
    this.estadoEmocionalModel,
    this.haDadoLuz = false,
  });

  RegisterState copyWith({
    int? currentStep,
    bool? isLoading,
    String? error,
    String? password,
    bool? isSuccess,
    RegistroBasicoModel? registroBasicoModel,
    PerfilMaternoModel? perfilMaternoModel,
    PerfilObstetricoModel? perfilObstetricoModel,
    PerfilMedicoModel? perfilMedicoModel,
    EmbarazoActualModel? embarazoActualModel,
    SenalesPeligroModel? senalesPeligroModel,
    RecienNacidoModel? recienNacidoModel,
    DatosBebeModel? datosBebeModel,
    EstadoEmocionalModel? estadoEmocionalModel,
    bool? haDadoLuz,
  }) {
    return RegisterState(
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      password: password ?? this.password,
      isSuccess: isSuccess ?? this.isSuccess,
      registroBasicoModel: registroBasicoModel ?? this.registroBasicoModel,
      perfilMaternoModel: perfilMaternoModel ?? this.perfilMaternoModel,
      perfilObstetricoModel:
          perfilObstetricoModel ?? this.perfilObstetricoModel,
      perfilMedicoModel: perfilMedicoModel ?? this.perfilMedicoModel,
      embarazoActualModel: embarazoActualModel ?? this.embarazoActualModel,
      senalesPeligroModel: senalesPeligroModel ?? this.senalesPeligroModel,
      recienNacidoModel: recienNacidoModel ?? this.recienNacidoModel,
      datosBebeModel: datosBebeModel ?? this.datosBebeModel,
      estadoEmocionalModel: estadoEmocionalModel ?? this.estadoEmocionalModel,
      haDadoLuz: haDadoLuz ?? this.haDadoLuz,
    );
  }
}
