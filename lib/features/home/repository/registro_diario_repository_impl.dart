import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/home/models/registro_diario_model.dart';
import 'package:lactaamor/features/home/repository/registro_diario_repository.dart';

class RegistroDiarioRepositoryImpl implements RegistroDiarioRepository {
  final FirebaseFirestore firestore;

  RegistroDiarioRepositoryImpl(this.firestore);

  @override
  Future<RegistroDiarioModel?> getRegistroPorFecha(
    String uid,
    String fechaKey,
  ) async {
    final doc = await firestore
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .doc(fechaKey)
        .get();

    if (!doc.exists) return null;
    return RegistroDiarioModel.fromFirestore(doc.data()!);
  }

  @override
  Future<List<RegistroDiarioModel>> getRegistrosPorTipo(
    String uid,
    String tipo,
  ) async {
    final query = await firestore
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .where('tipo', isEqualTo: tipo)
        .orderBy('fecha', descending: true)
        .get();

    return query.docs
        .map((doc) => RegistroDiarioModel.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<List<RegistroDiarioModel>> getTodosRegistros(String uid) async {
    final query = await firestore
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .orderBy('fecha', descending: true)
        .get();

    return query.docs
        .map((doc) => RegistroDiarioModel.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<void> registrarAlertasEnFirestore(
    String uid,
    List<Map<String, dynamic>> alertasDetectadas,
  ) async {
    final collection = firestore
        .collection('users')
        .doc(uid)
        .collection('alertas');
    for (var alerta in alertasDetectadas) {
      final docRef = collection.doc(alerta['id']);

      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        await docRef.set({
          'id_alerta': alerta['id'],
          'tipo': alerta['tipo'],
          'categoria': alerta['categoria'],
          'nivel': alerta['nivel'],
          'titulo': alerta['titulo'],
          'mensaje': alerta['mensaje'],
          'icono': alerta['icono'],
          'activa': true,
          'resuelta': false,
          'resuelta_manual': false,
          'fecha_inicio': Timestamp.now(),
          'fecha_resolucion': null,
        });
      } else {
        final data = snapshot.data()!;
        if (data['resuelta'] == true) {
          await docRef.update({
            'activa': true,
            'resuelta': false,
            'resuelta_manual': false,
            'fecha_inicio': Timestamp.now(),
            'fecha_resolucion': null,
          });
        }
      }
    }
  }

  @override
  Future<void> marcarAlertaResuelta(String uid, String alertaId) async {
    final docRef = firestore
        .collection('users')
        .doc(uid)
        .collection('alertas')
        .doc(alertaId);

    await docRef.update({
      'resuelta_manual': true,
      'resuelta': true,
      'activa': false,
      'fecha_resolucion': Timestamp.now(),
    });
  }
}
