import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_parametro.dart';
import 'package:lactaamor/features/contenidos/view/widgets/lista_articulos_screen.dart';

class ContenidoDetallesGeneral extends ConsumerWidget {
  const ContenidoDetallesGeneral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TemaContenido> embarazo = [];
    List<TemaContenido> lactancia = [];
    List<TemaContenido> cuidado = [];
    List<TemaContenido> vacunas = [];
    List<TemaContenido> alimentacion = [];

    //Embarazo
    final embarazoTema = todosLosTemas
        .where((tema) => tema.categoria == "Embarazo")
        .toList();

    if (embarazoTema.length >= 2) {
      embarazo = [embarazoTema[0], embarazoTema[1]];
    }

    //Lactancia
    final lactanciaTema = todosLosTemas
        .where((tema) => tema.categoria == "Lactancia")
        .toList();

    if (lactanciaTema.length >= 2) {
      lactancia = [lactanciaTema[0], lactanciaTema[1]];
    }

    //Cuidados
    final cuidadosTema = todosLosTemas
        .where((tema) => tema.categoria == "Cuidados del bebé")
        .toList();

    if (cuidadosTema.length >= 2) {
      cuidado = [cuidadosTema[0], cuidadosTema[1]];
    }

    //Vacunas
    final vacunasTema = todosLosTemas
        .where((tema) => tema.categoria == "Vacunas")
        .toList();

    if (vacunasTema.length >= 2) {
      vacunas = [vacunasTema[0], vacunasTema[1]];
    }

    //Alimentacion
    final alimentacionTema = todosLosTemas
        .where((tema) => tema.categoria == "Alimentacion")
        .toList();

    if (alimentacionTema.length >= 2) {
      alimentacion = [alimentacionTema[0], alimentacionTema[1]];
    }

    Widget cardTema(TemaContenido tema) {
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
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
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
        title: Text("Contenido"), // sin titulo

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, // estilo iOS
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Embarazo",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContenidoDetalleParametro(categoria: "Embarazo"),
                        ),
                      );
                    },
                    child: const Text("Ver más"),
                  ),
                ],
              ),
            ),
            Row(children: embarazo.map((tema) => cardTema(tema)).toList()),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lactancia",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContenidoDetalleParametro(categoria: "Lactancia"),
                        ),
                      );
                    },
                    child: const Text("Ver más"),
                  ),
                ],
              ),
            ),
            Row(children: lactancia.map((tema) => cardTema(tema)).toList()),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cuidados del bebé",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContenidoDetalleParametro(
                            categoria: "Cuidados del bebé",
                          ),
                        ),
                      );
                    },
                    child: const Text("Ver más"),
                  ),
                ],
              ),
            ),
            Row(children: cuidado.map((tema) => cardTema(tema)).toList()),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vacunas",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContenidoDetalleParametro(categoria: "Vacunas"),
                        ),
                      );
                    },
                    child: const Text("Ver más"),
                  ),
                ],
              ),
            ),
            Row(children: vacunas.map((tema) => cardTema(tema)).toList()),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alimentación",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContenidoDetalleParametro(
                            categoria: "Alimentacion",
                          ),
                        ),
                      );
                    },
                    child: const Text("Ver más"),
                  ),
                ],
              ),
            ),
            Row(children: alimentacion.map((tema) => cardTema(tema)).toList()),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
