import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/resultados_busqueda_screen.dart';

class BusquedaScreen extends StatefulWidget {
  final List<TemaContenido> todosLosTemas;

  const BusquedaScreen({super.key, required this.todosLosTemas});

  @override
  State<BusquedaScreen> createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen> {
  String textoBusqueda = '';
  String? categoriaFiltro;

  void _abrirResultados() {
    final resultados = widget.todosLosTemas
        .expand((tema) => tema.articulos)
        .where((articulo) {
          final matchTexto =
              articulo.titulo.toLowerCase().contains(
                textoBusqueda.toLowerCase(),
              ) ||
              articulo.descripcion.toLowerCase().contains(
                textoBusqueda.toLowerCase(),
              ) ||
              (articulo.tags?.any(
                    (tag) =>
                        tag.toLowerCase().contains(textoBusqueda.toLowerCase()),
                  ) ??
                  false);

          final matchCategoria =
              categoriaFiltro == null || categoriaFiltro == ''
              ? true
              : widget.todosLosTemas
                        .firstWhere((tema) => tema.articulos.contains(articulo))
                        .categoria ==
                    categoriaFiltro;

          return matchTexto && matchCategoria;
        })
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultadosBusquedaScreen(resultados: resultados),
      ),
    );
  }

  void _abrirFiltros() async {
    final categorias = widget.todosLosTemas
        .map((e) => e.categoria)
        .toSet()
        .toList();

    final seleccion = await showModalBottomSheet<String>(
      context: context,
      builder: (_) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Todas las categorías'),
              onTap: () => Navigator.pop(context, ''),
            ),
            ...categorias.map(
              (cat) => ListTile(
                title: Text(cat),
                onTap: () => Navigator.pop(context, cat),
              ),
            ),
          ],
        );
      },
    );

    if (seleccion != null) {
      setState(() {
        categoriaFiltro = seleccion;
      });
      _abrirResultados();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar contenido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Buscador
            Expanded(
              child: Container(
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
                  decoration: InputDecoration(
                    hintText: "Buscar contenido...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _abrirResultados(),
                  onChanged: (value) {
                    setState(() => textoBusqueda = value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Botón filtros
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: Theme.of(context).colorScheme.primary,
                ),
                tooltip: "Filtros",
                onPressed: _abrirFiltros,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
