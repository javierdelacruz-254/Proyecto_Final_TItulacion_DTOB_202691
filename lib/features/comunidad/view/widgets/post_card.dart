import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/comunidad/models/post_model.dart';
import 'package:lactaamor/features/comunidad/viewmodel/post_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final user = state.profile;

    final esMio = post.userId == user?.uid;

    DateTime createdAt = post.createdAt.toLocal();

    String timeAgo(DateTime date) {
      final now = DateTime.now();

      final today = DateTime(now.year, now.month, now.day);
      final postDay = DateTime(date.year, date.month, date.day);

      final difference = today.difference(postDay).inDays;

      if (difference == 0) {
        // mismo día
        final diff = now.difference(date);
        if (diff.inHours > 0) {
          return 'Hace ${diff.inHours} ${diff.inHours == 1 ? 'hora' : 'horas'}';
        } else if (diff.inMinutes > 0) {
          return 'Hace ${diff.inMinutes} ${diff.inMinutes == 1 ? 'minuto' : 'minutos'}';
        } else {
          return 'Hace un momento';
        }
      } else if (difference < 7) {
        return 'Hace $difference ${difference == 1 ? 'día' : 'días'}';
      } else if (difference < 30) {
        final semanas = (difference / 7).ceil();
        return 'Hace $semanas ${semanas == 1 ? 'semana' : 'semanas'}';
      } else if (difference < 365) {
        final meses = (difference / 30).ceil();
        return 'Hace $meses ${meses == 1 ? 'mes' : 'meses'}';
      } else {
        final anos = (difference / 365).ceil();
        return 'Hace $anos ${anos == 1 ? 'año' : 'años'}';
      }
    }

    void abrirComentariosModal(
      BuildContext context,
      PostModel post,
      user,
      WidgetRef ref,
    ) {
      final controller = TextEditingController();
      final isDark = Theme.of(context).brightness == Brightness.dark;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: isDark ? Color(0xFF1C2B2E) : AppColors.background,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            minChildSize: 0.4,
            builder: (_, scrollController) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "${post.commentsCount} comentarios",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(post.id)
                          .collection('comments')
                          .orderBy('created_at', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final comments = snapshot.data!.docs;

                        if (comments.isEmpty) {
                          return const Center(
                            child: Text("Sé la primera en comentar."),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final c =
                                comments[index].data() as Map<String, dynamic>;

                            final esAutor = c['user_id'] == post.userId;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    child: Text(
                                      c['user_name'][0].toUpperCase(),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              c['user_name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),

                                            const SizedBox(width: 6),

                                            // 👑 badge AUTOR
                                            if (esAutor)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange
                                                      .withOpacity(0.15),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: const Text(
                                                  "Autor",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),

                                        const SizedBox(height: 4),

                                        // 💬 comentario
                                        Text(
                                          c['comentario'],
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom +
                          MediaQuery.of(context).padding.bottom,
                      left: 12,
                      right: 12,
                      top: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xFF1C2B2E) : Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // 👤 avatar mini
                        CircleAvatar(
                          radius: 16,
                          child: Text(user.fullname[0].toUpperCase()),
                        ),

                        const SizedBox(width: 10),

                        // ✍️ input
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white10
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: controller,
                              minLines: 1,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: "Escribe un comentario...",
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 6),

                        // 🚀 botón enviar moderno
                        GestureDetector(
                          onTap: () async {
                            if (controller.text.trim().isEmpty) return;

                            await ref
                                .read(postViewModelProvider.notifier)
                                .comentar(
                                  postId: post.id,
                                  userId: user.uid,
                                  userName: user.fullname,
                                  comentario: controller.text.trim(),
                                );

                            controller.clear();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.send,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 👤 HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),

                            const SizedBox(width: 6),

                            // 🟢 Badge "Tú"
                            if (esMio)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "Tú",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 2),

                        Text(
                          post.haDadoLuz
                              ? 'Ya dio a luz • ${post.tiempoFormateado}'
                              : 'Embarazo • ${post.tiempoFormateado}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),

                  /// Tiempo
                  Text(
                    timeAgo(createdAt),
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// 📝 CONTENIDO
              Text(
                post.contenido,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),

              const SizedBox(height: 12),
              if (post.tags.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: -6,
                  children: post.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 20),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(postViewModelProvider.notifier)
                          .toggleLike(post, user!.uid);
                    },
                    icon: Icon(
                      post.likes.contains(user?.uid)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: post.likes.contains(user?.uid)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${post.likesCount}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(width: 20),

                  GestureDetector(
                    onTap: () {
                      abrirComentariosModal(context, post, user, ref);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${post.commentsCount}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
