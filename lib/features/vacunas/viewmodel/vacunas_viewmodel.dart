import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/vacunas/models/vacunas_model.dart';
import 'package:lactaamor/features/vacunas/viewmodel/vacunas_state.dart';
import '../repository/vacunas_repository.dart';
import '../repository/vacunas_repository_impl.dart';

final vacunasRepositoryProvider = Provider<VacunasRepository>((ref) {
  return VacunasRepositoryImpl(FirebaseFirestore.instance);
});

final vacunasViewModelProvider =
    StateNotifierProvider<VacunasViewModel, VacunasState>((ref) {
      final repo = ref.watch(vacunasRepositoryProvider);
      return VacunasViewModel(repo);
    });

class VacunasViewModel extends StateNotifier<VacunasState> {
  final VacunasRepository repository;

  VacunasViewModel(this.repository) : super(VacunasState());

  VacunasModel? vacunasModel;
  bool isLoading = false;
  String? error;

  Future<void> cargarVacunas(String uid) async {
    try {
      final data = await repository.cargarVacunasAplicadas(uid);

      state = state.copyWith(vacunasAplicadas: data);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> registrarVacuna(
    String uid,
    String vacunaId,
    DateTime fecha,
  ) async {
    await repository.registrarVacuna(uid, vacunaId, fecha);

    final nuevas = {
      ...state.vacunasAplicadas,
      vacunaId: {"fechaAplicacion": Timestamp.fromDate(fecha)},
    };

    state = state.copyWith(vacunasAplicadas: nuevas);
  }

  Future<void> obtenerVacunasInfo() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final vacunasModel = await repository.obtenerVacunas();

      state = state.copyWith(isLoading: false, vacunas: vacunasModel);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  bool estaAplicada(String vacunaId) {
    return state.vacunasAplicadas.containsKey(vacunaId);
  }
}
