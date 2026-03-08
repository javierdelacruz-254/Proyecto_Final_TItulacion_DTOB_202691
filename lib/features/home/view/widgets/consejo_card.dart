import 'package:flutter/material.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';

class ConsejoCard extends StatelessWidget {
  final int semanas;
  final bool dioALuz;
  final Map<String, List<Map<String, dynamic>>> recomendaciones;
  final Map<String, ArticuloContenido> articulosMap;
  const ConsejoCard({
    super.key,
    required this.semanas,
    required this.dioALuz,
    required this.recomendaciones,
    required this.articulosMap,
  });

  /// Obtiene consejo y su articuloId
  Map<String, String> _obtenerConsejo(int semanas, bool dioALuz) {
    final tipo = dioALuz ? "postparto" : "embarazo";
    final lista = recomendaciones[tipo]!;

    for (var rango in lista) {
      if (semanas >= rango["min"] && semanas <= rango["max"]) {
        List tips = rango["tips"];
        tips.shuffle();
        final tip = tips.first;
        return {"texto": tip["texto"], "articuloId": tip["articuloId"]};
      }
    }

    return {
      "texto": "Cuida tu salud y bienestar y consulta a tu especialista.",
      "articuloId": "",
    };
  }

  @override
  Widget build(BuildContext context) {
    final consejoMap = _obtenerConsejo(semanas, dioALuz);
    final texto = consejoMap["texto"]!;
    final articuloId = consejoMap["articuloId"]!;

    return GestureDetector(
      onTap: () {
        if (articuloId.isNotEmpty && articulosMap.containsKey(articuloId)) {
          final articulo = articulosMap[articuloId]!;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ContenidoDetalleScreen(articulo: articulo),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Artículo no disponible")),
          );
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card principal
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icono al inicio
                  const Icon(Icons.lightbulb, size: 28, color: Colors.white),
                  const SizedBox(width: 12),

                  // Texto principal
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recomendación del día",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          texto,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Flecha al final
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // Badge "Importante" encima del card
          Positioned(
            left: 32,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade300,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.priority_high, size: 16, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "IMPORTANTE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
