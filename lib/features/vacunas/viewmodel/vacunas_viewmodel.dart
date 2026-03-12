import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repository/vacunas_repository.dart';
import '../repository/vacunas_repository_impl.dart';

final vacunasRepositoryProvider = Provider<VacunasRepository>((ref) {
  return VacunasRepositoryImpl(FirebaseFirestore.instance);
});

final vacunasViewModelProvider =
    StateNotifierProvider<VacunasViewModel, Map<String, dynamic>>((ref) {
      final repo = ref.watch(vacunasRepositoryProvider);
      return VacunasViewModel(repo);
    });

class VacunasViewModel extends StateNotifier<Map<String, dynamic>> {
  final VacunasRepository repository;

  VacunasViewModel(this.repository) : super({});

  Future<void> cargarVacunas(String uid) async {
    final data = await repository.cargarVacunasAplicadas(uid);
    state = data;
  }

  Future<void> registrarVacuna(
    String uid,
    String vacunaId,
    DateTime fecha,
  ) async {
    await repository.registrarVacuna(uid, vacunaId, fecha);

    state = {
      ...state,
      vacunaId: {"fechaAplicacion": Timestamp.fromDate(fecha)},
    };
  }
}
