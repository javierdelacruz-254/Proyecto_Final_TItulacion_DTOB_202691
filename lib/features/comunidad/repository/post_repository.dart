import 'package:lactaamor/features/comunidad/models/post_model.dart';

abstract class PostRepository {
  Stream<List<PostModel>> getPosts();

  Future<void> crearPost({
    required String userId,
    required String userName,
    required bool haDadoLuz,
    DateTime? fechaReferencia,
    required String contenido,
    required List<String> tags,
  });

  Future<void> toggleLike(String postId, String userId, bool isLiked);

  Future<void> agregarComentario({
    required String postId,
    required String userId,
    required String userName,
    required String comentario,
  });
}
