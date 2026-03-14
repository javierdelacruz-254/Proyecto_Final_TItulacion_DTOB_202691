import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mini Comunidad",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Comparte con otras madres tu experiencia.",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 120.0,
          right: 3,
        ), // ajusta bottom para subir
        child: FloatingActionButton(
          onPressed: () => abrirCrearPostModal(context, user, ref),
          tooltip: 'Crear post',
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

void abrirCrearPostModal(BuildContext context, dynamic user, WidgetRef ref) {
  final contenidoController = TextEditingController();
  final tagsController = TextEditingController();
  bool loading = false;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateModal) {
          Future<void> publicarPost() async {
            final contenido = contenidoController.text.trim();
            final tagsTexto = tagsController.text.trim();
            if (contenido.isEmpty) return;

            setStateModal(() {
              loading = true;
            });

            final List<String> tags = tagsTexto.isEmpty
                ? []
                : tagsTexto.split(",").map((e) => e.trim()).toList();

            await ref
                .read(postViewModelProvider.notifier)
                .crearPost(
                  user.uid,
                  user.fullname ?? "",
                  user.haDadoLuz,
                  user.haDadoLuz
                      ? user.fechaNacimientoBebe
                      : user.ultimaMenstruacion,
                  contenido,
                  tags,
                );

            Navigator.pop(context);
          }

          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xFF0F1A1C) : AppColors.background,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicador de arrastrar
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Título
                      Text(
                        "Crear publicación",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),

                      // Contenido
                      TextField(
                        controller: contenidoController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText:
                              "Comparte tu experiencia con otras madres...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,

                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tags
                      TextField(
                        controller: tagsController,
                        decoration: InputDecoration(
                          hintText: "Tags (ej: lactancia,sueño,bebé)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,

                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Botón Publicar
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loading ? null : publicarPost,
                          child: loading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: isDark
                                        ? AppColors.textPrimary
                                        : Colors.white,
                                  ),
                                )
                              : Text(
                                  "Publicar",
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textPrimary
                                        : Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
