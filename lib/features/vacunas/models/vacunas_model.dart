import 'package:lactaamor/features/vacunas/models/grupo_vacuna_model.dart';

class VacunasModel {
  final String pais;
  final String fuente;
  final String version;
  final List<GrupoVacunaModel> vacunasBebe;
  final List<GrupoVacunaModel> vacunasMadre;

  VacunasModel({
    required this.pais,
    required this.fuente,
    required this.version,
    required this.vacunasBebe,
    required this.vacunasMadre,
  });

  factory VacunasModel.fromJson(Map<String, dynamic> json) {
    return VacunasModel(
      pais: json['pais'],
      fuente: json['fuente'],
      version: json['version'],
      vacunasBebe: (json['vacunas_bebe'] as List)
          .map((e) => GrupoVacunaModel.fromJson(e))
          .toList(),
      vacunasMadre: (json['vacunas_madre'] as List)
          .map((e) => GrupoVacunaModel.fromJson(e))
          .toList(),
    );
  }
}
