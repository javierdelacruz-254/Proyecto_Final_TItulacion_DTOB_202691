import 'package:flutter/material.dart';
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1C2B2E),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Row(
                children: const [
                  Icon(Icons.baby_changing_station, size: 24),
                  SizedBox(width: 8),
                  Text(
                    "Cuidados importantes hoy",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Lista de cuidados
              Column(
                children: cuidados.asMap().entries.map((entry) {
                  final index = entry.key;
                  final cuidado = entry.value;

                  return GestureDetector(
                    onTap: () {
                      final articuloId = cuidado["articuloId"];
                      if (articuloId != null &&
                          articulosMap.containsKey(articuloId)) {
                        final articulo = articulosMap[articuloId]!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ContenidoDetalleScreen(articulo: articulo),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Artículo no disponible"),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.yellow.shade50.withOpacity(0.3)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              cuidado["titulo"],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: index == 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        if (cuidados.isNotEmpty)
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade300,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  "RECOMENDADO",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
