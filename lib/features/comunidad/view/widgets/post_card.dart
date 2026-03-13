import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/comunidad/models/post_model.dart';
import 'package:lactaamor/features/comunidad/viewmodel/post_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;

  const PostCard({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final user = state.profile;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// USER
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  child: Icon(Icons.person, size: 18),
                ),

                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Hace un momento",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// CONTENIDO
            Text(post.contenido, style: const TextStyle(fontSize: 15)),

            const SizedBox(height: 10),

            /// TAGS
            Wrap(
              spacing: 6,
              children: post.tags.map((tag) {
                return Chip(
                  label: Text("#$tag"),
                  backgroundColor: Colors.blue.shade50,
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            /// ACCIONES
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {
                    ref
                        .read(postViewModelProvider.notifier)
                        .likePost(post.id, user?.uid ?? '');
                  },
                ),

                Text(
                  post.likesCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(width: 20),

                const Icon(Icons.chat_bubble_outline),

                const SizedBox(width: 4),

                Text(post.commentsCount.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
