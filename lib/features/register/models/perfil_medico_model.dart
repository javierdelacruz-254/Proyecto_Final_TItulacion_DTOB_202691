class PerfilMedicoModel {
  final bool diabetes;
  final bool hipertension;
  final bool enfermedadesAutoinmunes;
  final bool hipoHiperTiroidismo;
  final bool obesidad;
  final bool anemiaGrave;
  final bool enfermedadesCardiacas;
  final String? otros;

  PerfilMedicoModel({
    required this.diabetes,
    required this.hipertension,
    required this.enfermedadesAutoinmunes,
    required this.hipoHiperTiroidismo,
    required this.obesidad,
    required this.anemiaGrave,
    required this.enfermedadesCardiacas,
    this.otros,
  });

  factory PerfilMedicoModel.fromFirestore(Map<String, dynamic> json) {
    return PerfilMedicoModel(
      diabetes: json['diabetes'] as bool? ?? false,
      hipertension: json['hipertension'] as bool? ?? false,
      enfermedadesAutoinmunes:
          json['enfermedadesAutoinmunes'] as bool? ?? false,
      hipoHiperTiroidismo: json['hipoHiperTiroidismo'] as bool? ?? false,
      obesidad: json['obesidad'] as bool? ?? false,
      anemiaGrave: json['anemiaGrave'] as bool? ?? false,
      enfermedadesCardiacas: json['enfermedadesCardiacas'] as bool? ?? false,
      otros: json['otros'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'diabetes': diabetes,
      'hipertension': hipertension,
      'enfermedadesAutoinmunes': enfermedadesAutoinmunes,
      'hipoHiperTiroidismo': hipoHiperTiroidismo,
      'obesidad': obesidad,
      'anemiaGrave': anemiaGrave,
      'enfermedadesCardiacas': enfermedadesCardiacas,
      'otros': otros,
    };
  }

  PerfilMedicoModel copyWith({
    bool? diabetes,
    bool? hipertension,
    bool? enfermedadesAutoinmunes,
    bool? hipoHiperTiroidismo,
    bool? obesidad,
    bool? anemiaGrave,
    bool? enfermedadesCardiacas,
    String? otros,
  }) {
    return PerfilMedicoModel(
      diabetes: diabetes ?? this.diabetes,
      hipertension: hipertension ?? this.hipertension,
      enfermedadesAutoinmunes:
          enfermedadesAutoinmunes ?? this.enfermedadesAutoinmunes,
      hipoHiperTiroidismo: hipoHiperTiroidismo ?? this.hipoHiperTiroidismo,
      obesidad: obesidad ?? this.obesidad,
      anemiaGrave: anemiaGrave ?? this.anemiaGrave,
      enfermedadesCardiacas:
          enfermedadesCardiacas ?? this.enfermedadesCardiacas,
      otros: otros ?? this.otros,
    );
  }
}
