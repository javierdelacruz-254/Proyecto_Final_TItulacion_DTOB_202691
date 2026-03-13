import 'package:lactaamor/features/comunidad/models/post_model.dart';

abstract class PostRepository {
  Stream<List<PostModel>> getPosts();

  Future<void> crearPost({
    required String userId,
    required String userName,
    required String contenido,
    required List<String> tags,
  });

  Future<void> likePost(String postId, String userId);

  Future<void> crearComentario({
    required String postId,
    required String userId,
    required String userName,
    required String texto,
  });
}
