import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/comunidad/models/post_model.dart';
import 'package:lactaamor/features/comunidad/viewmodel/post_viewmodel.dart';
import 'package:lactaamor/features/comunidad/view/widgets/post_card.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';

class ComunidadScreen extends ConsumerStatefulWidget {
  const ComunidadScreen({super.key});

  @override
  ConsumerState<ComunidadScreen> createState() => _ComunidadScreenState();
}

class _ComunidadScreenState extends ConsumerState<ComunidadScreen> {
  int filtroSeleccionado = 0;
  Widget _buildFiltro(String texto, IconData icono, int index) {
    final isSelected = filtroSeleccionado == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          filtroSeleccionado = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icono,
              size: 16,
              color: isSelected ? Colors.black : Colors.grey.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              texto,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _busquedaController = TextEditingController();

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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _busquedaController,
                        readOnly: true, // 🔥 solo diseño (no abre teclado)
                        decoration: InputDecoration(
                          hintText: "Buscar...",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),

                          // 🔥 opcional visual (simula botón clear)
                          suffixIcon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFiltro("Recientes", Icons.schedule, 0),
                  const SizedBox(width: 10),
                  _buildFiltro("Tus posts", Icons.person, 1),
                  const SizedBox(width: 10),
                  _buildFiltro("Likes", Icons.favorite, 2),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: postsState.when(
                data: (posts) {
                  List<PostModel> filteredPosts = [];
                  if (filtroSeleccionado == 0) {
                    // Recientes (todo)
                    filteredPosts = posts;
                  } else if (filtroSeleccionado == 1) {
                    // Tus posts
                    filteredPosts = posts
                        .where((p) => p.userId == user?.uid)
                        .toList();
                  } else if (filtroSeleccionado == 2) {
                    // Me gustas
                    filteredPosts = posts
                        .where((p) => p.likes.contains(user?.uid))
                        .toList();
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: ListView.builder(
                      key: ValueKey(filtroSeleccionado),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];
                        return PostCard(post: post);
                      },
                    ),
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
