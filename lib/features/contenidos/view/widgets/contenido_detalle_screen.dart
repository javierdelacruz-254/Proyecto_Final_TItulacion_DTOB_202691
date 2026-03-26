import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/utils/favorito_manager.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContenidoDetalleScreen extends ConsumerStatefulWidget {
  final ArticuloContenido articulo;

  const ContenidoDetalleScreen({super.key, required this.articulo});

  @override
  ConsumerState<ContenidoDetalleScreen> createState() =>
      _ContenidoDetalleScreenState();
}

class _ContenidoDetalleScreenState
    extends ConsumerState<ContenidoDetalleScreen> {
  @override
  Widget build(BuildContext context) {
    final articulo = widget.articulo;

    final isFavorito = FavoritosManager.instance.isFavorito(articulo);

    final state = ref.watch(homeViewModelProvider);
    final user = state.profile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const SizedBox(), // sin titulo

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(isFavorito ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () async {
                  if (user == null) return;
                  await FavoritosManager.instance.toggleFavorito(
                    articulo,
                    user.uid,
                  );
                  setState(() {});
                },
              ),
            ],
          ),

          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 260,
                  child: Image.network(articulo.imagen, fit: BoxFit.cover),
                ),

                Container(
                  height: 260,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 20,
                  child: Text(
                    articulo.titulo,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Container(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...articulo.bloques
                          .where((b) => b.tipo != TipoBloque.titulo)
                          .map((bloque) {
                            switch (bloque.tipo) {
                              case TipoBloque.texto:
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    bloque.valor,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.6,
                                    ),
                                  ),
                                );

                              case TipoBloque.lista:
                                final items = bloque.valor.split(",");

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: items.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(top: 6),
                                              child: Icon(
                                                Icons.circle,
                                                size: 6,
                                              ),
                                            ),

                                            const SizedBox(width: 10),

                                            Expanded(
                                              child: Text(
                                                item.trim(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.6,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );

                              case TipoBloque.tip:
                                return Container(
                                  padding: const EdgeInsets.all(14),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.lightbulb_outline,
                                            size: 18,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            "Consejo",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        bloque.valor,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                              case TipoBloque.advertencia:
                                return Container(
                                  padding: const EdgeInsets.all(14),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 18,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            "Advertencia",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        bloque.valor,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
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

                              default:
                                return const SizedBox();
                            }
                          }),

                      if (articulo.fuente != null &&
                          articulo.fuente!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Fuente: ${articulo.fuente}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
