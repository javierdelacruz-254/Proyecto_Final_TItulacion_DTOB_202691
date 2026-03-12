import 'package:lactaamor/features/home/models/registro_diario_model.dart';

abstract class RegistroDiarioRepository {
  Future<RegistroDiarioModel?> getRegistroPorFecha(String uid, String fechaKey);

  Future<List<RegistroDiarioModel>> getTodosRegistros(String uid);

  Future<List<RegistroDiarioModel>> getRegistrosPorTipo(
    String uid,
    String tipo,
  );

  Future<void> registrarAlertasEnFirestore(
    String uid,
    List<Map<String, dynamic>> alertasDetectadas,
  );

  Future<void> marcarAlertaResuelta(String uid, String alertaId);
}
