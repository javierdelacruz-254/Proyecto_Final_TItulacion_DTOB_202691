import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/core/utils/favorito_manager.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_parametro.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalles_general.dart';
import 'package:lactaamor/features/contenidos/view/widgets/favoritos_screen.dart';
import 'package:lactaamor/features/contenidos/view/widgets/lista_articulos_screen.dart';
import 'package:lactaamor/features/contenidos/viewmodel/favorito_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';

class ContenidoScreen extends ConsumerStatefulWidget {
  const ContenidoScreen({super.key});

  @override
  ConsumerState<ContenidoScreen> createState() => _ContenidoScreenState();
}

class _ContenidoScreenState extends ConsumerState<ContenidoScreen> {
  final TextEditingController _busquedaController = TextEditingController();
  OverlayEntry? _overlayEntry;
  List<ArticuloContenido> _resultados = [];
  String? _categoriaFiltro;

  @override
  void dispose() {
    _busquedaController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _mostrarOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        top: offset.dy + 160,
        left: 16,
        right: 16,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 350),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: _resultados.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No se encontraron resultados'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: _resultados.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final articulo = _resultados[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            articulo.imagen,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(articulo.titulo),
                        subtitle: Text(
                          articulo.descripcion,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: FavoritosManager.instance.isFavorito(articulo)
                            ? Icon(Icons.bookmark, color: AppColors.primary)
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ContenidoDetalleScreen(articulo: articulo),
                            ),
                          );
                          _removeOverlay();
                        },
                      );
                    },
                  ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _actualizarResultados(String texto) {
    if (texto.trim().isEmpty) {
      _removeOverlay();
      setState(() => _resultados = []);
      return;
    }

    final todosLosArticulos = todosLosTemas.expand((t) => t.articulos).toList();

    setState(() {
      _resultados = todosLosArticulos.where((articulo) {
        final matchTexto =
            articulo.titulo.toLowerCase().contains(texto.toLowerCase()) ||
            articulo.descripcion.toLowerCase().contains(texto.toLowerCase()) ||
            (articulo.tags?.any(
                  (tag) => tag.toLowerCase().contains(texto.toLowerCase()),
                ) ??
                false);

        final matchCategoria =
            _categoriaFiltro == null || _categoriaFiltro == ''
            ? true
            : todosLosTemas
                      .firstWhere((tema) => tema.articulos.contains(articulo))
                      .categoria ==
                  _categoriaFiltro;

        return matchTexto && matchCategoria;
      }).toList();
    });

    if (_resultados.isNotEmpty) {
      if (_overlayEntry == null) {
        _mostrarOverlay();
      } else {
        _overlayEntry!.markNeedsBuild();
      }
    } else {
      _removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    final user = state.profile;

    final dioALuz = user?.haDadoLuz ?? false;

    Widget categoriaItem(IconData icono, String titulo, String categoria) {
      return InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ContenidoDetalleParametro(categoria: categoria),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.12),
              ),
              child: Icon(icono, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              titulo,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    int obtenerSemanaDelAnio() {
      final ahora = DateTime.now();
      final inicioAnio = DateTime(ahora.year, 1, 1);
      final dias = ahora.difference(inicioAnio).inDays;
      return (dias / 7).floor();
    }

    final semana = obtenerSemanaDelAnio();

    //Articulos  mas populares
    List<ArticuloContenido> articulosMostrar = [];

    if (!dioALuz) {
      final temasEmbarazo = todosLosTemas
          .where((tema) => tema.categoria == "Embarazo")
          .expand((tema) => tema.articulos)
          .toList();

      if (temasEmbarazo.isNotEmpty) {
        final inicio = semana % temasEmbarazo.length;

        articulosMostrar = [
          temasEmbarazo[inicio],
          temasEmbarazo[(inicio + 1) % temasEmbarazo.length],
        ];
      }
    } else {
      final lactancia = todosLosTemas
          .where((tema) => tema.categoria == "Lactancia")
          .expand((tema) => tema.articulos)
          .toList();

      if (lactancia.isNotEmpty) {
        final inicio = semana % lactancia.length;

        articulosMostrar = [
          lactancia[inicio],
          lactancia[(inicio + 1) % lactancia.length],
        ];
      }
    }

    //Articulos de esta semana para ella
    List<ArticuloContenido> articulosMostrarSemana = [];
    if (!dioALuz) {
      final embarazo = todosLosTemas
          .where((tema) => tema.categoria == "Embarazo")
          .expand((tema) => tema.articulos)
          .toList();

      if (embarazo.isNotEmpty) {
        final inicio = semana % embarazo.length;

        articulosMostrarSemana = [
          embarazo[inicio],
          embarazo[(inicio + 1) % embarazo.length],
          embarazo[(inicio + 2) % embarazo.length],
        ];
      }
    } else {
      final cuidadosBebe = todosLosTemas
          .where((tema) => tema.categoria == "Cuidados del bebé")
          .expand((tema) => tema.articulos)
          .toList();

      if (cuidadosBebe.isNotEmpty) {
        final inicio = semana % cuidadosBebe.length;

        articulosMostrarSemana = [
          cuidadosBebe[inicio],
          cuidadosBebe[(inicio + 1) % cuidadosBebe.length],
          cuidadosBebe[(inicio + 2) % cuidadosBebe.length],
        ];
      }
    }

    List<TemaContenido> embarazo = [];
    List<TemaContenido> lactancia = [];
    List<TemaContenido> cuidado = [];

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget cardArticulo(ArticuloContenido articulo) {
      return Consumer(
        builder: (context, ref, _) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final isFavorito = ref
              .watch(favoritosProvider)
              .any((a) => a.id == articulo.id);

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContenidoDetalleScreen(articulo: articulo),
                    ),
                  );
                  setState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        articulo.imagen,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () {
                            final user = ref
                                .read(homeViewModelProvider)
                                .profile;
                            if (user != null) {
                              ref
                                  .read(favoritosProvider.notifier)
                                  .toggle(articulo, user.uid);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isFavorito
                                  ? AppColors.primary
                                  : Colors.white70,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.bookmark,
                              color: isFavorito
                                  ? Colors.white
                                  : Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        ),
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
                            articulo.titulo,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textPrimary
                                      : Colors.white,
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
        },
      );
    }

    Widget cardArticuloSemana(ArticuloContenido articulo) {
      return Consumer(
        builder: (context, ref, _) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final isFavorito = ref
              .watch(favoritosProvider)
              .any((a) => a.id == articulo.id);

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContenidoDetalleScreen(articulo: articulo),
                    ),
                  );
                  setState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        articulo.imagen,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () {
                            final user = ref
                                .read(homeViewModelProvider)
                                .profile;
                            if (user != null) {
                              ref
                                  .read(favoritosProvider.notifier)
                                  .toggle(articulo, user.uid);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isFavorito
                                  ? AppColors.primary
                                  : Colors.white70,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.bookmark,
                              color: isFavorito
                                  ? Colors.white
                                  : Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        ),
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
                            articulo.titulo,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textPrimary
                                      : Colors.white,
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
        },
      );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dioALuz
                              ? "Contenido para ti madre"
                              : "Contenido para ti futura madre",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Guías y recursos para el cuidado de la madre y el bebé",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // Botón favoritos
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.bookmark_border,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      tooltip: "Guardados",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FavoritosScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                // Buscador
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _busquedaController,
                      decoration: InputDecoration(
                        hintText: "Buscar contenido...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),

                        // padding interno
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),

                        // borde redondeado SOLO para este input
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1,
                          ),
                        ),
                      ),
                      onChanged: _actualizarResultados,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      categoriaItem(
                        Icons.pregnant_woman,
                        "Embarazo",
                        "Embarazo",
                      ),
                      categoriaItem(Icons.child_care, "Lactancia", "Lactancia"),
                      categoriaItem(
                        Icons.bedroom_baby,
                        "Cuidados",
                        "Cuidados del bebé",
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Segunda fila (2 centrados)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      categoriaItem(Icons.vaccines, "Vacunación", "Vacunas"),
                      const SizedBox(width: 30),
                      categoriaItem(
                        Icons.restaurant,
                        "Alimentación",
                        "Alimentacion",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dioALuz
                        ? "Más populares en lactancia"
                        : "Más populares en embarazo",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: articulosMostrar
                  .map((articulo) => cardArticulo(articulo))
                  .toList(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contenido de esta semana",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: articulosMostrarSemana
                  .map((articulo) => cardArticuloSemana(articulo))
                  .toList(),
            ),
            SizedBox(height: 20),
            if (dioALuz == false) ...[
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
                            builder: (context) => ContenidoDetalleParametro(
                              categoria: "Embarazo",
                            ),
                          ),
                        );
                      },
                      child: const Text("Ver más"),
                    ),
                  ],
                ),
              ),
              Row(children: embarazo.map((tema) => cardTema(tema)).toList()),

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
                            builder: (context) => ContenidoDetalleParametro(
                              categoria: "Lactancia",
                            ),
                          ),
                        );
                      },
                      child: const Text("Ver más"),
                    ),
                  ],
                ),
              ),
              Row(children: lactancia.map((tema) => cardTema(tema)).toList()),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContenidoDetallesGeneral(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: isDark ? AppColors.textPrimary : Colors.white,
                  ),
                  label: Text(
                    "Ver más",
                    style: TextStyle(
                      color: isDark ? AppColors.textPrimary : Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ] else ...[
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
                            builder: (context) => ContenidoDetalleParametro(
                              categoria: "Lactancia",
                            ),
                          ),
                        );
                      },
                      child: const Text("Ver más"),
                    ),
                  ],
                ),
              ),
              Row(children: lactancia.map((tema) => cardTema(tema)).toList()),

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
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContenidoDetallesGeneral(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: isDark ? AppColors.textPrimary : Colors.white,
                  ),
                  label: Text(
                    "Ver más",
                    style: TextStyle(
                      color: isDark ? AppColors.textPrimary : Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}

// =================EXTENSIÓN PARA evitar error firstWhere =================
extension FirstOrNullExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
