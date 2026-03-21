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

  @override
  Future<void> agregarComentario({
    required String postId,
    required String userId,
    required String userName,
    required String comentario,
  }) async {
    final commentRef = firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc();

    await commentRef.set({
      'id': commentRef.id,
      'user_id': userId,
      'user_name': userName,
      'comentario': comentario,
      'created_at': Timestamp.now(),
    });

    // actualizar contador
    await firestore.collection('posts').doc(postId).update({
      'comments_count': FieldValue.increment(1),
    });
  }

  @override
  Future<void> toggleLike(String postId, String userId, bool isLiked) async {
    final doc = firestore.collection('posts').doc(postId);

    if (isLiked) {
      // quitar like
      await doc.update({
        'likes': FieldValue.arrayRemove([userId]),
        'likes_count': FieldValue.increment(-1),
      });
    } else {
      // dar like
      await doc.update({
        'likes': FieldValue.arrayUnion([userId]),
        'likes_count': FieldValue.increment(1),
      });
    }
  }
}
