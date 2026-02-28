class PerfilMedicoModel {
  final bool tbc;
  final bool diabetes;
  final bool hipertension;
  final bool cirugiaPelvica;
  final bool infertilidad;
  final bool anemia;
  final bool epilepsia;
  final bool cardiopatia;
  final String? otros;

  final bool tbcFamiliar;
  final bool diabetesFamiliar;
  final bool hipertensionFamiliar;
  final String? otrosFamiliar;

  PerfilMedicoModel({
    required this.tbc,
    required this.diabetes,
    required this.hipertension,
    required this.cirugiaPelvica,
    required this.infertilidad,
    required this.anemia,
    required this.epilepsia,
    required this.cardiopatia,
    this.otros,
    required this.tbcFamiliar,
    required this.diabetesFamiliar,
    required this.hipertensionFamiliar,
    this.otrosFamiliar,
  });

  factory PerfilMedicoModel.fromFirestore(Map<String, dynamic> json) {
    return PerfilMedicoModel(
      tbc: json['tbc'] as bool? ?? false,
      diabetes: json['diabetes'] as bool? ?? false,
      hipertension: json['hipertension'] as bool? ?? false,
      cirugiaPelvica: json['cirugia_pelvica'] as bool? ?? false,
      infertilidad: json['infertilidad'] as bool? ?? false,
      anemia: json['anemia'] as bool? ?? false,
      epilepsia: json['epilepsia'] as bool? ?? false,
      cardiopatia: json['cardiopatia'] as bool? ?? false,
      otros: json['otros'] as String?,
      tbcFamiliar: json['tbc_familiar'] as bool? ?? false,
      diabetesFamiliar: json['diabetes_familiar'] as bool? ?? false,
      hipertensionFamiliar: json['hipertension_familiar'] as bool? ?? false,
      otrosFamiliar: json['otros_familiar'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'tbc': tbc,
      'diabetes': diabetes,
      'hipertension': hipertension,
      'cirugia_pelvica': cirugiaPelvica,
      'infertilidad': infertilidad,
      'anemia': anemia,
      'epilepsia': epilepsia,
      'cardiopatia': cardiopatia,
      'otros': otros,
      'tbc_familiar': tbcFamiliar,
      'diabetes_familiar': diabetesFamiliar,
      'hipertension_familiar': hipertensionFamiliar,
      'otros_familiar': otrosFamiliar,
    };
  }

  PerfilMedicoModel copyWith({
    bool? tbc,
    bool? diabetes,
    bool? hipertension,
    bool? cirugiaPelvica,
    bool? infertilidad,
    bool? anemia,
    bool? epilepsia,
    bool? cardiopatia,
    String? otros,
    bool? tbcFamiliar,
    bool? diabetesFamiliar,
    bool? hipertensionFamiliar,
    String? otrosFamiliar,
  }) {
    return PerfilMedicoModel(
      tbc: tbc ?? this.tbc,
      diabetes: diabetes ?? this.diabetes,
      hipertension: hipertension ?? this.hipertension,
      cirugiaPelvica: cirugiaPelvica ?? this.cirugiaPelvica,
      infertilidad: infertilidad ?? this.infertilidad,
      anemia: anemia ?? this.anemia,
      epilepsia: epilepsia ?? this.epilepsia,
      cardiopatia: cardiopatia ?? this.cardiopatia,
      otros: otros ?? this.otros,
      tbcFamiliar: tbcFamiliar ?? this.tbcFamiliar,
      diabetesFamiliar: diabetesFamiliar ?? this.diabetesFamiliar,
      hipertensionFamiliar: hipertensionFamiliar ?? this.hipertensionFamiliar,
      otrosFamiliar: otrosFamiliar ?? this.otrosFamiliar,
    );
  }
}
