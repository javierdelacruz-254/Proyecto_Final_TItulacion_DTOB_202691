import 'package:lactaamor/features/vacunas/models/vacunas_model.dart';

abstract class VacunasRepository {
  Future<void> registrarVacuna(
    String uid,
    String vacunaId,
    DateTime fechaAplicacion,
  );

  Future<Map<String, dynamic>> cargarVacunasAplicadas(String uid);

  Future<VacunasModel> obtenerVacunas();
}
