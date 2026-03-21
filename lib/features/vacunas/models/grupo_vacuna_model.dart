import 'package:lactaamor/features/vacunas/models/individual_vacuna_model.dart';

class GrupoVacunaModel {
  final String edad;
  final int? edadMeses;
  final int? trimestre;
  final List<IndividualVacunaModel> vacunas;

  GrupoVacunaModel({
    required this.edad,
    this.edadMeses,
    this.trimestre,
    required this.vacunas,
  });

  factory GrupoVacunaModel.fromJson(Map<String, dynamic> json) {
    return GrupoVacunaModel(
      edad: json['edad'],
      edadMeses: json['edad_meses'],
      trimestre: json['trimestre'],
      vacunas: (json['vacunas'] as List)
          .map((e) => IndividualVacunaModel.fromJson(e))
          .toList(),
    );
  }
}
