import 'package:flutter/material.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/lista_articulos_screen.dart';

class ContenidoDetalleParametro extends StatelessWidget {
  final String categoria;

  const ContenidoDetalleParametro({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    final temasCategoria = todosLosTemas
        .where((tema) => tema.categoria == categoria)
        .toList();

    Widget _cardTema(TemaContenido tema) {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaArticulosScreen(tema: tema),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    tema.imagen,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.85),
                      ),
                      child: Text(
                        tema.titulo,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textPrimary : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text("Contenido de $categoria"), // sin titulo

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, // estilo iOS
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: temasCategoria.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columnas
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return _cardTema(temasCategoria[index]);
        },
      ),
    );
  }
}
