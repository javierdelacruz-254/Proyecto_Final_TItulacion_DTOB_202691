import 'package:flutter/material.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContenidoDetalleScreen extends StatefulWidget {
  final ArticuloContenido articulo;

  const ContenidoDetalleScreen({super.key, required this.articulo});

  @override
  State<ContenidoDetalleScreen> createState() => _ContenidoDetalleScreenState();
}

class _ContenidoDetalleScreenState extends State<ContenidoDetalleScreen> {
  @override
  Widget build(BuildContext context) {
    final articulo = widget.articulo;

    return Scaffold(
      appBar: AppBar(title: Text(articulo.titulo)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                articulo.imagen,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // bloques dinámicos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: articulo.bloques.map((bloque) {
                  switch (bloque.tipo) {
                    case TipoBloque.texto:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            bloque.valor,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6, // mejor line-height para lectura
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );

                    case TipoBloque.imagen:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(bloque.valor),
                        ),
                      );

                    case TipoBloque.video:
                      final controller = YoutubePlayerController(
                        initialVideoId: bloque.valor,
                        flags: const YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                        ),
                      );

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: YoutubePlayer(
                          controller: controller,
                          showVideoProgressIndicator: true,
                        ),
                      );
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
