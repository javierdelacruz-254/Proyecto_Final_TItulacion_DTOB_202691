import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/vacunas/repository/vacunas_repository.dart';

class VacunasRepositoryImpl implements VacunasRepository {
  final FirebaseFirestore firebase;

  VacunasRepositoryImpl(this.firebase);
  @override
  Future<void> registrarVacuna(
    String uid,
    String vacunaId,
    DateTime fechaAplicacion,
  ) async {
    await firebase
        .collection('users')
        .doc(uid)
        .collection('vacunas_bebe')
        .doc(vacunaId)
        .set({"fechaAplicacion": Timestamp.fromDate(fechaAplicacion)});
  }

  @override
  Future<Map<String, dynamic>> cargarVacunasAplicadas(String uid) async {
    final snapshot = await firebase
        .collection('users')
        .doc(uid)
        .collection('vacunas_bebe')
        .get();

    final Map<String, dynamic> vacunas = {};

    for (var doc in snapshot.docs) {
      vacunas[doc.id] = doc.data();
    }

    return vacunas;
  }
}
