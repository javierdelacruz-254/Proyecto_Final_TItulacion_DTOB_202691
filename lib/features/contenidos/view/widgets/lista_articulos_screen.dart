import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/core/utils/favorito_manager.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'contenido_detalle_screen.dart';
import 'articulo_webview_screen.dart';

class ListaArticulosScreen extends StatelessWidget {
  final TemaContenido tema;

  const ListaArticulosScreen({super.key, required this.tema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(tema.titulo), // sin titulo

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, // estilo iOS
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tema.articulos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final articulo = tema.articulos[index];

          return InkWell(
            borderRadius: BorderRadius.circular(12),

            onTap: () {
              if (articulo.urlExterna != null &&
                  articulo.urlExterna!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticuloWebviewScreen(
                      titulo: articulo.titulo,
                      url: articulo.urlExterna!,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContenidoDetalleScreen(articulo: articulo),
                  ),
                );
              }
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
                  Stack(
                    children: [
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
                      if (FavoritosManager.instance.isFavorito(articulo))
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary, // fondo llamativo
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.bookmark,
                              color: Colors.white, // icono dentro del círculo
                              size: 18,
                            ),
                          ),
                        ),
                    ],
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
