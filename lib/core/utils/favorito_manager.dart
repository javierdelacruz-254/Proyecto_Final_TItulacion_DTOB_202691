import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosManager {
  FavoritosManager._privateConstructor();
  static final FavoritosManager instance =
      FavoritosManager._privateConstructor();

  final List<ArticuloContenido> _favoritos = [];

  List<ArticuloContenido> get favoritos => List.unmodifiable(_favoritos);

  Future<void> _guardarIdsFavoritos(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = _favoritos.map((a) => a.id).toList();
    await prefs.setStringList('favoritos_$userId', ids);
  }

  Future<void> cargarFavoritos(
    String userId,
    List<TemaContenido> todosLosTemas,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final idsGuardados = prefs.getStringList('favoritos_$userId') ?? [];

    _favoritos.clear();
    for (var articulo in todosLosTemas.expand((t) => t.articulos)) {
      if (idsGuardados.contains(articulo.id)) {
        _favoritos.add(articulo);
      }
    }
  }

  bool isFavorito(ArticuloContenido articulo) {
    return _favoritos.any((a) => a.id == articulo.id);
  }

  Future<void> toggleFavorito(ArticuloContenido articulo, String userId) async {
    if (isFavorito(articulo)) {
      _favoritos.removeWhere((a) => a.id == articulo.id);
    } else {
      _favoritos.add(articulo);
    }
    await _guardarIdsFavoritos(userId);
  }
}
