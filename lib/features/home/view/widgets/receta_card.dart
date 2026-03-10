import 'package:flutter/material.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';
import 'package:lactaamor/features/home/models/user_profile_model.dart';

class RecetaCard extends StatelessWidget {
  final UserProfileModel user;
  final Map<String, ArticuloContenido> articulosMap;
  final List<Map<String, dynamic>> todosRecetas;

  const RecetaCard({
    super.key,
    required this.user,
    required this.articulosMap,
    required this.todosRecetas,
  });

  ArticuloContenido? _obtenerRecetaDelDiaPorSeccion(String seccion) {
    List<Map<String, dynamic>> posiblesRecetas = [];

    if (user.haDadoLuz) {
      // Postparto
      posiblesRecetas = todosRecetas.where((r) {
        final condicion = r["condicion"];
        final articuloId = r["articuloId"];
        if (articuloId == null || articuloId.isEmpty) return false;

        if (user.anemiaGrave == true &&
            condicion == "anemiaLactancia" &&
            seccion == "madre") {
          return true;
        }
        if (user.lactanciaMaterna == true &&
            condicion == "lactanciaExclusiva" &&
            seccion == "bebe") {
          return true;
        }

        if (condicion == null && r["seccion"] == seccion) return true;

        return false;
      }).toList();
    } else {
      // Embarazo -> solo madre neutra
      posiblesRecetas = todosRecetas.where((r) {
        final articuloId = r["articuloId"];
        if (articuloId == null || articuloId.isEmpty) return false;
        return r["seccion"] == "madre";
      }).toList();
    }

    if (posiblesRecetas.isEmpty) return null;

    final indice = DateTime.now().day % posiblesRecetas.length;
    final receta = posiblesRecetas[indice];
    final articuloId = receta["articuloId"];
    if (articuloId != null && articulosMap.containsKey(articuloId)) {
      return articulosMap[articuloId];
    }
    return null;
  }

  Widget _buildRecetaCard(
    BuildContext context,
    ArticuloContenido receta,
    String tituloSeccion,
  ) {
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
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
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
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tituloSeccion,
                      style: const TextStyle(
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [];

    if (!user.haDadoLuz) {
      // Caso embarazo -> madre
      final madreReceta = _obtenerRecetaDelDiaPorSeccion("madre");
      if (madreReceta != null) {
        cards.add(_buildRecetaCard(context, madreReceta, "Receta para ti hoy"));
      }
    } else {
      // Postparto -> madre y bebe
      final madreReceta = _obtenerRecetaDelDiaPorSeccion("madre");
      final bebeReceta = _obtenerRecetaDelDiaPorSeccion("bebe");

      if (madreReceta != null) {
        cards.add(
          _buildRecetaCard(context, madreReceta, "Receta para la madre"),
        );
      }
      if (bebeReceta != null) {
        cards.add(_buildRecetaCard(context, bebeReceta, "Receta para el bebé"));
      }
    }

    if (cards.isEmpty) {
      return const SizedBox();
    }

    return Column(children: cards);
  }
}
