import 'package:flutter/material.dart';
import 'package:lactaamor/core/constants/recetas_data.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';
import 'package:lactaamor/features/home/models/user_profile_model.dart';

class RecetaCard extends StatelessWidget {
  final UserProfileModel user;
  final Map<String, ArticuloContenido> articulosMap;
  final List<Map<String, dynamic>>
  todosRecetas; // Lista de tus datos tipo madre/condicion

  const RecetaCard({
    super.key,
    required this.user,
    required this.articulosMap,
    required this.todosRecetas,
  });

  ArticuloContenido? _obtenerRecetaDelDia() {
    List<Map<String, dynamic>> posiblesRecetas = [];

    if (user.haDadoLuz) {
      // Si ya dio a luz
      posiblesRecetas = recetas.where((r) {
        // Filtra recetas para postparto
        final condicion = r["condicion"];
        final articuloId = r["articuloId"];
        if (articuloId == null || articuloId.isEmpty) return false;

        if (user.anemiaGrave == true && condicion == "anemiaLactancia")
          return true;
        if (user.lactanciaMaterna == true && condicion == "lactanciaExclusiva")
          return true;

        // Si no tiene ninguna condición especial, puede recomendar recetas "madre" neutras
        if (condicion == null && r["seccion"] == "madre") return true;

        return false;
      }).toList();
    } else {
      // Embarazo: filtra recetas neutras de madre
      posiblesRecetas = todosRecetas.where((r) {
        final articuloId = r["articuloId"];
        if (articuloId == null || articuloId.isEmpty) return false;
        return r["seccion"] == "madre";
      }).toList();
    }

    if (posiblesRecetas.isEmpty) return null;

    posiblesRecetas.shuffle(); // Aleatorio
    final receta = posiblesRecetas.first;
    final articuloId = receta["articuloId"];
    if (articuloId != null && articulosMap.containsKey(articuloId)) {
      return articulosMap[articuloId];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final receta = _obtenerRecetaDelDia();

    if (receta == null) {
      return const SizedBox(); // No hay receta disponible
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ContenidoDetalleScreen(articulo: receta),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Imagen pequeña a la izquierda
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Image.network(
                receta.imagen,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            // Espacio interno
            const SizedBox(width: 12),

            // Información
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Receta del día",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      receta.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      receta.descripcion,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Flecha pequeña al final
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
