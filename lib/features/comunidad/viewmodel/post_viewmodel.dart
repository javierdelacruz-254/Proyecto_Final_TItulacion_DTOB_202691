import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/comunidad/models/post_model.dart';
import 'package:lactaamor/features/comunidad/repository/post_repository.dart';
import 'package:lactaamor/features/comunidad/repository/post_repository_impl.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(FirebaseFirestore.instance);
});

final postViewModelProvider =
    StateNotifierProvider<PostViewmodel, AsyncValue<List<PostModel>>>(
      (ref) => PostViewmodel(ref),
    );

class PostViewmodel extends StateNotifier<AsyncValue<List<PostModel>>> {
  final Ref ref;

  PostViewmodel(this.ref) : super(const AsyncLoading()) {
    _loadPosts();
  }

  void _loadPosts() {
    final repo = ref.read(postRepositoryProvider);

    repo.getPosts().listen((posts) {
      state = AsyncData(posts);
    });
  }

  Future<void> crearPost(
    String userId,
    String userName,
    bool haDadoLuz,
    DateTime? fechaReferencia,
    String contenido,
    List<String> tags,
  ) async {
    final repo = ref.read(postRepositoryProvider);

    await repo.crearPost(
      userId: userId,
      userName: userName,
      haDadoLuz: haDadoLuz,
      fechaReferencia: fechaReferencia,
      contenido: contenido,
      tags: tags,
    );
  }

  Future<void> toggleLike(PostModel post, String userId) async {
    final repo = ref.read(postRepositoryProvider);

    final isLiked = post.likes.contains(userId);

    await repo.toggleLike(post.id, userId, isLiked);
  }

  Future<void> comentar({
    required String postId,
    required String userId,
    required String userName,
    required String comentario,
  }) async {
    final repo = ref.read(postRepositoryProvider);

    await repo.agregarComentario(
      postId: postId,
      userId: userId,
      userName: userName,
      comentario: comentario,
    );
  }
}
