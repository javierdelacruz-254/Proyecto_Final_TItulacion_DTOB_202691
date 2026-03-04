import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/home/models/user_profile_model.dart';
import 'package:lactaamor/features/home/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseFirestore firestore;

  HomeRepositoryImpl(this.firestore);

  @override
  Future<UserProfileModel> getUserProfile(String uid) async {
    print('🔎 Obteniendo perfil de usuario UID: $uid');
    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      print('⚠ Documento no encontrado para UID: $uid');
      throw Exception("Usuario no encontrado");
    }

    final data = doc.data();
    print('📄 Datos del documento: $data');

    return UserProfileModel.fromFirestore(data!);
  }
}
