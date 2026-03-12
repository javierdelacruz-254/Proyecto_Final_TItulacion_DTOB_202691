abstract class VacunasRepository {
  Future<void> registrarVacuna(
    String uid,
    String vacunaId,
    DateTime fechaAplicacion,
  );

  Future<Map<String, dynamic>> cargarVacunasAplicadas(String uid);
}
