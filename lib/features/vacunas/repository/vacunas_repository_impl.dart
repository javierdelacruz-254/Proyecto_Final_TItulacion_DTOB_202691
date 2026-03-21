import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/vacunas/models/vacunas_model.dart';
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

  @override
  Future<VacunasModel> obtenerVacunas() async {
    try {
      final doc = await firebase.collection('config').doc('vacunas_info').get();

      if (!doc.exists) {
        throw Exception("No existe vacunas_info");
      }

      final data = doc.data() as Map<String, dynamic>;

      return VacunasModel.fromJson(data);
    } catch (e) {
      throw Exception("Error al obtener vacunas: $e");
    }
  }
}
