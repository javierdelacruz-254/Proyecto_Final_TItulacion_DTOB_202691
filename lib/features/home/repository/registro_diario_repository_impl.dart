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
}
