import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/home/repository/home_repository.dart';
import 'package:lactaamor/features/home/repository/home_repository_impl.dart';
import 'package:lactaamor/features/home/viewmodel/home_state.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(FirebaseFirestore.instance);
});

final homeViewModelProvider = StateNotifierProvider<HomeViewmodel, HomeState>((
  ref,
) {
  final homeRepository = ref.read(homeRepositoryProvider);
  final auth = FirebaseAuth.instance;
  return HomeViewmodel(homeRepository, auth);
});

class HomeViewmodel extends StateNotifier<HomeState> {
  final HomeRepository homeRepository;
  final FirebaseAuth auth;

  HomeViewmodel(this.homeRepository, this.auth) : super(HomeState());

  Future<void> loadUser() async {
    final uid = auth.currentUser?.uid;

    if (uid == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final profile = await homeRepository.getUserProfile(uid);

      state = state.copyWith(isLoading: false, profile: profile);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
