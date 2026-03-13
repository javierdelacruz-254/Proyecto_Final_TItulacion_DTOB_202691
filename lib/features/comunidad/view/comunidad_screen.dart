import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/comunidad/view/crear_post_screen.dart';
import 'package:lactaamor/features/comunidad/viewmodel/post_viewmodel.dart';
import 'package:lactaamor/features/comunidad/view/widgets/post_card.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';

class ComunidadScreen extends ConsumerWidget {
  const ComunidadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postViewModelProvider);
    final state = ref.watch(homeViewModelProvider);
    final user = state.profile;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.diversity_3, size: 26),
                  SizedBox(width: 10),
                  Text(
                    "Comunidad",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            /// CREAR POST
            _crearPostCard(context, user),

            const SizedBox(height: 10),

            /// LISTA POSTS
            Expanded(
              child: postsState.when(
                data: (posts) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return PostCard(post: post);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    const Center(child: Text("Error cargando posts")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _crearPostCard(BuildContext context, user) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        const CircleAvatar(radius: 18, child: Icon(Icons.person)),

        const SizedBox(width: 10),

        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CrearPostScreen(user: user)),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "¿Qué quieres compartir?",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
