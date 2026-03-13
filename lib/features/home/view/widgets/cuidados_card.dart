import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';

class CuidadosHoyCard extends StatelessWidget {
  final List<Map<String, dynamic>> cuidados; // lista filtrada según edad
  final Map<String, ArticuloContenido> articulosMap;

  const CuidadosHoyCard({
    super.key,
    required this.cuidados,
    required this.articulosMap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.baby_changing_station, size: 24),
                  SizedBox(width: 8),
                  Text(
                    "Cuidados importantes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 130,
                child: Row(
                  children: cuidados.take(3).map((cuidado) {
                    final articuloId = cuidado["articuloId"];
                    final articulo = articuloId != null
                        ? articulosMap[articuloId]
                        : null;

                    final imagen = articulo?.imagen;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (articulo != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ContenidoDetalleScreen(articulo: articulo),
                              ),
                            );
                          }
                        },

                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.black.withOpacity(0.08),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// IMAGEN
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: SizedBox(
                                  height: 80,
                                  width: double.infinity,
                                  child: imagen != null
                                      ? Image.network(imagen, fit: BoxFit.cover)
                                      : Container(color: Colors.grey.shade300),
                                ),
                              ),

                              /// TEXTO
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    cuidado["titulo"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
