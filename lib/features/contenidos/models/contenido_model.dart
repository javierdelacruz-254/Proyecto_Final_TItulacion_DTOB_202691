enum TipoBloque { texto, imagen, video }

class ContenidoBloque {
  final TipoBloque tipo;
  final String valor;

  ContenidoBloque({required this.tipo, required this.valor});
}

class ArticuloContenido {
  final String titulo;
  final String descripcion;
  final String imagen;
  final List<ContenidoBloque> bloques;
  final String? urlExterna;

  ArticuloContenido({
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.bloques,
    this.urlExterna,
  });
}

class TemaContenido {
  final String titulo;
  final String imagen;
  final String descripcion;
  final List<ArticuloContenido> articulos;

  TemaContenido({
    required this.titulo,
    required this.imagen,
    required this.descripcion,
    required this.articulos,
  });
}
