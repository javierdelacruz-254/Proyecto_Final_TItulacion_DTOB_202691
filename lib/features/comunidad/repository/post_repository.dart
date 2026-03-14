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
}
