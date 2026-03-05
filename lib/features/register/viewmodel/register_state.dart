import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';

class RegisterState {
  final int currentStep;
  final bool isLoading;
  final String? error;
  final String? password;
  final bool isSuccess;

  final RegistroBasicoModel? registroBasicoModel;
  final PerfilMaternoModel? perfilMaternoModel;
  final PerfilMedicoModel? perfilMedicoModel;
  final EmbarazoActualModel? embarazoActualModel;
  final DatosBebeModel? datosBebeModel;

  final bool haDadoLuz;

  RegisterState({
    this.currentStep = 0,
    this.isLoading = false,
    this.error,
    this.password,
    this.isSuccess = false,
    this.registroBasicoModel,
    this.perfilMaternoModel,
    this.perfilMedicoModel,
    this.embarazoActualModel,
    this.datosBebeModel,
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
    PerfilMedicoModel? perfilMedicoModel,
    EmbarazoActualModel? embarazoActualModel,
    DatosBebeModel? datosBebeModel,
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
      perfilMedicoModel: perfilMedicoModel ?? this.perfilMedicoModel,
      embarazoActualModel: embarazoActualModel ?? this.embarazoActualModel,
      datosBebeModel: datosBebeModel ?? this.datosBebeModel,
      haDadoLuz: haDadoLuz ?? this.haDadoLuz,
    );
  }
}
