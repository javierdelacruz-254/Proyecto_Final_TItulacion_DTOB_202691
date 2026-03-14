import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/comunidad/models/post_model.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;

  const PostCard({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

                    Text(
                      post.haDadoLuz
                          ? 'Postparto: ${post.semanas} semanas (${post.dias} días)'
                          : 'Embarazo: ${post.semanas} semanas (${post.dias} días)',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    Text(
                      timeAgo(createdAt),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(post.contenido, style: const TextStyle(fontSize: 15)),

            const SizedBox(height: 10),

            Wrap(
              spacing: 6,
              children: post.tags.map((tag) {
                return Chip(
                  label: Text(
                    "#$tag",
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  backgroundColor: AppColors.primaryLight,
                );
              }).toList(),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
