import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';
import 'package:lactaamor/features/contenidos/viewmodel/favorito_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';

class FavoritosScreen extends ConsumerStatefulWidget {
  const FavoritosScreen({super.key});

  @override
  ConsumerState<FavoritosScreen> createState() => _FavoritoScreenState();
}

class _FavoritoScreenState extends ConsumerState<FavoritosScreen> {
  List<ArticuloContenido> favoritos = [];

  @override
  void initState() {
    super.initState();
    final state = ref.read(homeViewModelProvider);
    final user = state.profile;

    if (user != null) {
      ref.read(favoritosProvider.notifier).cargar(user.uid, todosLosTemas);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritos = ref.watch(favoritosProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text("Mis Favoritos"),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: favoritos.isEmpty
          ? const Center(child: Text('No tienes artículos favoritos aún.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favoritos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final articulo = favoritos[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ContenidoDetalleScreen(articulo: articulo),
                      ),
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // IMAGEN
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            articulo.imagen,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 90,
                                height: 90,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        // TEXTO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articulo.titulo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                articulo.descripcion,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.bookmark_remove,
                            color: Colors.redAccent,
                          ),
                          tooltip: "Eliminar de favoritos",
                          onPressed: () {
                            final user = ref
                                .read(homeViewModelProvider)
                                .profile;
                            if (user != null) {
                              ref
                                  .read(favoritosProvider.notifier)
                                  .toggle(articulo, user.uid);
                            }
                          },
                        ),

                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
