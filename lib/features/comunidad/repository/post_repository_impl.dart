import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactaamor/features/comunidad/models/post_model.dart';
import 'package:lactaamor/features/comunidad/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final FirebaseFirestore firestore;

  PostRepositoryImpl(this.firestore);

  @override
  Future<void> crearPost({
    required String userId,
    required String userName,
    required bool haDadoLuz,
    DateTime? fechaReferencia,
    required String contenido,
    required List<String> tags,
  }) async {
    await firestore.collection('posts').add({
      'user_id': userId,
      'user_name': userName,
      'haDadoLuz': haDadoLuz,
      'fechaReferencia': fechaReferencia != null
          ? Timestamp.fromDate(fechaReferencia)
          : null,

      'contenido': contenido,
      'tags': tags,
      'likes_count': 0,
      'comments_count': 0,
      'created_at': Timestamp.now(),
    });
  }

  @override
  Stream<List<PostModel>> getPosts() {
    return firestore
        .collection('posts')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList(),
        );
  }
}
