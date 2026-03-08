import 'package:flutter/material.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'contenido_detalle_screen.dart';
import 'articulo_webview_screen.dart';

class ListaArticulosScreen extends StatelessWidget {
  final TemaContenido tema;

  const ListaArticulosScreen({super.key, required this.tema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tema.titulo)),
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
