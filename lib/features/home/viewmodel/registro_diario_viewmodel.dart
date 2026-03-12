import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/home/models/registro_diario_model.dart';
import 'package:lactaamor/features/home/repository/registro_diario_repository.dart';
import 'package:lactaamor/features/home/repository/registro_diario_repository_impl.dart';

final registroDiarioViewModelProvider =
    ChangeNotifierProvider<RegistroDiarioViewmodel>((ref) {
      final repository = RegistroDiarioRepositoryImpl(
        FirebaseFirestore.instance,
      );
      return RegistroDiarioViewmodel(repository: repository);
    });

class RegistroDiarioViewmodel extends ChangeNotifier {
  final RegistroDiarioRepository repository;

  RegistroDiarioViewmodel({required this.repository});

  RegistroDiarioModel? registroDiarioModel;
  List<RegistroDiarioModel> todosRegistros = [];
  bool isLoading = false;

  Future<void> cargarRegistroDelDia(String uid, String fechaKey) async {
    isLoading = true;
    notifyListeners();

    registroDiarioModel = await repository.getRegistroPorFecha(uid, fechaKey);

    isLoading = false;
    notifyListeners();
  }

  Future<void> cargarTodosRegistros(String uid) async {
    isLoading = true;
    notifyListeners();

    todosRegistros = await repository.getTodosRegistros(uid);

    isLoading = false;
    notifyListeners();
  }

  Future<void> cargarRegistrosPorTipo(String uid, String tipo) async {
    isLoading = true;
    notifyListeners();

    todosRegistros = await repository.getRegistrosPorTipo(uid, tipo);

    isLoading = false;
    notifyListeners();
  }
}
