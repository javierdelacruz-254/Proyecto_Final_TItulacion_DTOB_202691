import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/utils/favorito_manager.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';

class FavoritosNotifier extends StateNotifier<List<ArticuloContenido>> {
  FavoritosNotifier() : super([]);

  void cargar(String userId, List<TemaContenido> todosLosTemas) async {
    await FavoritosManager.instance.cargarFavoritos(userId, todosLosTemas);
    state = FavoritosManager.instance.favoritos;
  }

  void toggle(ArticuloContenido articulo, String userId) async {
    await FavoritosManager.instance.toggleFavorito(articulo, userId);
    state = FavoritosManager.instance.favoritos; // actualizar el estado
  }
}

// Provider global
final favoritosProvider =
    StateNotifierProvider<FavoritosNotifier, List<ArticuloContenido>>(
      (ref) => FavoritosNotifier(),
    );
