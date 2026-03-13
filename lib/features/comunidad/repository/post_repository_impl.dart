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
    required String contenido,
    required List<String> tags,
  }) async {
    await firestore.collection('posts').add({
      'user_id': userId,
      'user_name': userName,
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
  Future<void> likePost(String postId, String userId) async {
    final likeRef = firestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userId);

    final snapshot = await likeRef.get();

    if (snapshot.exists) {
      await likeRef.delete();
    } else {
      await likeRef.set({'created_at': Timestamp.now()});
    }
  }

  @override
  Future<void> crearComentario({
    required String postId,
    required String userId,
    required String userName,
    required String texto,
  }) async {
    final postRef = firestore.collection('posts').doc(postId);

    await postRef.collection('commets').add({
      'user_id': userId,
      'user_name': userName,
      'texto': texto,
      'created_at': Timestamp.now(),
    });

    await postRef.update({'comments_count': FieldValue.increment(1)});
  }
}
