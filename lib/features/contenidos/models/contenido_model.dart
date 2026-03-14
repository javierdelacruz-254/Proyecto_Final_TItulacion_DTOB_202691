enum TipoBloque { titulo, texto, imagen, video, lista, tip, advertencia }

class TemaContenido {
  final String titulo;
  final String imagen;
  final String descripcion;
  final String categoria;
  final List<ArticuloContenido> articulos;

  TemaContenido({
    required this.titulo,
    required this.imagen,
    required this.descripcion,
    required this.categoria,
    required this.articulos,
  });
}

class ArticuloContenido {
  final String id;
  final String titulo;
  final String descripcion;
  final String imagen;
  final List<ContenidoBloque> bloques;
  final String? fuente;
  final String? urlExterna;
  final List<String>? tags;

  ArticuloContenido({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.bloques,
    this.fuente,
    this.urlExterna,
    this.tags,
  });
}

class ContenidoBloque {
  final TipoBloque tipo;
  final String valor;

  ContenidoBloque({required this.tipo, required this.valor});
}
