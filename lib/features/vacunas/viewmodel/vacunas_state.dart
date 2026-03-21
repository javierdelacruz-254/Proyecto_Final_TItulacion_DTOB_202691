import 'package:lactaamor/features/vacunas/models/vacunas_model.dart';

class VacunasState {
  final bool isLoading;
  final String? error;
  final VacunasModel? vacunas;
  final Map<String, dynamic> vacunasAplicadas;

  VacunasState({
    this.isLoading = false,
    this.error,
    this.vacunas,
    this.vacunasAplicadas = const {},
  });

  VacunasState copyWith({
    bool? isLoading,
    String? error,
    VacunasModel? vacunas,
    Map<String, dynamic>? vacunasAplicadas,
  }) {
    return VacunasState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      vacunas: vacunas ?? this.vacunas,
      vacunasAplicadas: vacunasAplicadas ?? this.vacunasAplicadas,
    );
  }
}
