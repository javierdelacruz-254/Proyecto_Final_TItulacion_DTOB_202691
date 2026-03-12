import 'package:flutter/material.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';
import 'package:lactaamor/features/home/models/registro_diario_model.dart';

class ConsejoCard extends StatefulWidget {
  final int semanas;
  final bool dioALuz;
  final Map<String, List<Map<String, dynamic>>> recomendaciones;
  final Map<String, ArticuloContenido> articulosMap;
  final RegistroDiarioModel? registroBasicoModel;

  const ConsejoCard({
    super.key,
    required this.semanas,
    required this.dioALuz,
    required this.recomendaciones,
    required this.articulosMap,
    this.registroBasicoModel,
  });

  @override
  State<ConsejoCard> createState() => _ConsejoCardState();
}

class _ConsejoCardState extends State<ConsejoCard> {
  late final Map<String, String> consejoMap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consejoMap = _obtenerConsejo(widget.semanas, widget.dioALuz);
  }

  /// Obtiene consejo y su articuloId
  Map<String, String> _obtenerConsejo(int semanas, bool dioALuz) {
    final tipo = dioALuz ? "postparto" : "embarazo";
    final lista = widget.recomendaciones[tipo]!;

    Map<String, dynamic>? rangoSeleccionado;
    for (var rango in lista) {
      if (semanas >= rango["min"] && semanas <= rango["max"]) {
        rangoSeleccionado = rango;
        break;
      }
    }

    if (rangoSeleccionado == null) {
      // fallback
      return {
        "texto": "Cuida tu salud y bienestar y consulta a tu especialista.",
        "articuloId": "",
      };
    }

    final tips = List<Map<String, dynamic>>.from(rangoSeleccionado["tips"]);

    if (widget.registroBasicoModel == null) {
      final tip = tips[DateTime.now().day % tips.length];
      return {"texto": tip["texto"], "articuloId": tip["articuloId"]};
    }

    List<Map<String, dynamic>> tipsValidos = [];
    for (var tip in tips) {
      bool valido = true;

      // Validaciones embarazo
      if (tip.containsKey("estado_animo")) {
        if ((widget.registroBasicoModel!.estadoAnimo ?? 0) <
            tip["estado_animo"]) {
          valido = false;
        }
      }
      if (tip.containsKey("horas_sueno")) {
        final min = tip["horas_sueno"]["min"] ?? 0;
        final max = tip["horas_sueno"]["max"] ?? 99;
        final hs = widget.registroBasicoModel!.horasSueno ?? 0;
        if (hs < min || hs > max) valido = false;
      }
      if (tip.containsKey("vitaminas_prenatales")) {
        if ((widget.registroBasicoModel!.vitaminasPrenatales ?? false) !=
            tip["vitaminas_prenatales"]) {
          valido = false;
        }
      }
      if (tip.containsKey("hierro")) {
        if ((widget.registroBasicoModel!.hierro ?? false) != tip["hierro"]) {
          valido = false;
        }
      }
      if (tip.containsKey("movimientos_fetales")) {
        final min = tip["movimientos_fetales"]["min"] ?? 0;
        final max = tip["movimientos_fetales"]["max"] ?? 99;
        final mov = widget.registroBasicoModel!.movimientosFetales ?? 0;
        if (mov < min || mov > max) valido = false;
      }
      if (tip.containsKey("tomas_lactancia")) {
        if ((widget.registroBasicoModel!.tomasLactancia ?? 0) == 0) {
          valido = false;
        }
      }
      if (tip.containsKey("vasos_agua")) {
        final min = tip["vasos_agua"]["min"] ?? 0;
        final max = tip["vasos_agua"]["max"] ?? 99;
        final v = widget.registroBasicoModel!.vasosAgua ?? 0;
        if (v < min || v > max) valido = false;
      }

      if (valido) tipsValidos.add(tip);
    }

    Map<String, dynamic> tipSeleccionado;

    if (tipsValidos.isNotEmpty) {
      tipSeleccionado =
          tipsValidos[DateTime.now().day %
              tipsValidos.length]; // random pero consistente
    } else {
      tipSeleccionado = tips[DateTime.now().day % tips.length]; // fallback
    }

    return {
      "texto": tipSeleccionado["texto"],
      "articuloId": tipSeleccionado["articuloId"],
    };
  }

  @override
  Widget build(BuildContext context) {
    final texto = consejoMap["texto"]!;
    final articuloId = consejoMap["articuloId"]!;

    return GestureDetector(
      onTap: () {
        if (articuloId.isNotEmpty &&
            widget.articulosMap.containsKey(articuloId)) {
          final articulo = widget.articulosMap[articuloId]!;
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
                  const Icon(Icons.lightbulb, size: 20, color: Colors.white),
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
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          texto,
                          style: TextStyle(
                            fontSize: 12,
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
