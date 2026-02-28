import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/repository/register_repository.dart';
import 'package:lactaamor/features/register/repository/register_repository_impl.dart';
import 'package:lactaamor/features/register/viewmodel/register_state.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/models/estado_emocional_model.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/models/perfil_obstetrico_model.dart';
import 'package:lactaamor/features/register/models/recien_nacido_model.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/models/senales_peligro_model.dart';

final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  return RegisterRepositoryImpl(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  );
});

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewmodel, RegisterState>((ref) {
      final registerRepository = ref.read(registerRepositoryProvider);
      return RegisterViewmodel(registerRepository);
    });

class RegisterViewmodel extends StateNotifier<RegisterState> {
  final RegisterRepository registerRepository;

  RegisterViewmodel(this.registerRepository) : super(RegisterState());

  void setRegistroBasico(RegistroBasicoModel model) {
    state = state.copyWith(registroBasicoModel: model);
  }

  void setPerfilMaterno(PerfilMaternoModel model) {
    state = state.copyWith(perfilMaternoModel: model);
  }

  void setPerfilObstetrico(PerfilObstetricoModel model) {
    state = state.copyWith(perfilObstetricoModel: model);
  }

  void setPerfilMedico(PerfilMedicoModel model) {
    state = state.copyWith(perfilMedicoModel: model);
  }

  void setEmbarazoActual(EmbarazoActualModel model) {
    state = state.copyWith(embarazoActualModel: model);
  }

  void setSenalesPeligro(SenalesPeligroModel model) {
    state = state.copyWith(senalesPeligroModel: model);
  }

  void setRecienNacido(RecienNacidoModel model) {
    state = state.copyWith(recienNacidoModel: model);
  }

  void setDatosBebe(DatosBebeModel model) {
    state = state.copyWith(datosBebeModel: model);
  }

  void setEstadoEmocional(EstadoEmocionalModel model) {
    state = state.copyWith(estadoEmocionalModel: model);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setHaDadoLuz(bool value) {
    state = state.copyWith(haDadoLuz: value);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> submit() async {
    final esValido =
        state.registroBasicoModel != null &&
        state.perfilMaternoModel != null &&
        state.perfilObstetricoModel != null &&
        state.perfilMedicoModel != null &&
        state.senalesPeligroModel != null &&
        state.estadoEmocionalModel != null &&
        (state.haDadoLuz
            ? state.recienNacidoModel != null && state.datosBebeModel != null
            : state.embarazoActualModel != null);

    if (!esValido) {
      state = state.copyWith(error: "Formulario incompleto");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final stateData = state;

      if (stateData.registroBasicoModel == null) return;
      if (stateData.password == null) return;

      await registerRepository.saveRegistroCompleto(
        datosBebe: state.datosBebeModel,
        embarazoActual: state.embarazoActualModel,
        estadoEmocional: state.estadoEmocionalModel!,
        perfilMaterno: state.perfilMaternoModel!,
        perfilMedico: state.perfilMedicoModel!,
        perfilObstetrico: state.perfilObstetricoModel!,
        recienNacido: state.recienNacidoModel,
        registroBasico: state.registroBasicoModel!,
        password: stateData.password!,
        senalesPeligro: state.senalesPeligroModel!,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
