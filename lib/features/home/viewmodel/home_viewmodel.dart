import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/home/repository/home_repository.dart';
import 'package:lactaamor/features/home/repository/home_repository_impl.dart';
import 'package:lactaamor/features/home/viewmodel/home_state.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(FirebaseFirestore.instance);
});

final homeViewModelProvider =
    StateNotifierProvider<HomeViewmodel, HomeState>((ref) {
  final homeRepository = ref.read(homeRepositoryProvider);
  final auth = FirebaseAuth.instance;
  return HomeViewmodel(homeRepository, auth);
});

class HomeViewmodel extends StateNotifier<HomeState> {
  final HomeRepository homeRepository;
  final FirebaseAuth auth;

  HomeViewmodel(this.homeRepository, this.auth) : super(HomeState()) {
    // 👇 Escucha cambios de auth automáticamente
    // Cuando Firebase restaura la sesión, carga el perfil solo
    auth.authStateChanges().listen((user) {
      if (user != null) {
        loadUser(uid: user.uid);
      } else {
        // Usuario cerró sesión — limpiamos el estado
        state = HomeState();
      }
    });
  }

  Future<void> loadUser({String? uid}) async {
    // Usamos el uid que nos pasan o el del usuario actual
    final userId = uid ?? auth.currentUser?.uid;

    if (userId == null) {
      print('⚠ loadUser: no hay usuario autenticado');
      return;
    }

    print('📥 Cargando perfil para UID: $userId');
    state = state.copyWith(isLoading: true);

    try {
      final profile = await homeRepository.getUserProfile(userId);
      print('✅ Perfil cargado: ${profile.fullname}');
      state = state.copyWith(isLoading: false, profile: profile);
    } catch (e) {
      print('❌ Error cargando perfil: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}