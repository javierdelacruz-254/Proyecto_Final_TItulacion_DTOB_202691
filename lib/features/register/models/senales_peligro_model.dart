class SenalesPeligroModel {
  final bool vomitoExcesivo;
  final bool sangradoVaginal;
  final bool fiebre;
  final bool hinchazon;
  final bool dolorCabeza;

  SenalesPeligroModel({
    required this.vomitoExcesivo,
    required this.sangradoVaginal,
    required this.fiebre,
    required this.hinchazon,
    required this.dolorCabeza,
  });

  factory SenalesPeligroModel.fromFirestore(Map<String, dynamic> json) {
    return SenalesPeligroModel(
      vomitoExcesivo: json['vomito_excesivo'] as bool? ?? false,
      sangradoVaginal: json['sangrado_vaginal'] as bool? ?? false,
      fiebre: json['fiebre'] as bool? ?? false,
      hinchazon: json['hinchazon'] as bool? ?? false,
      dolorCabeza: json['dolor_cabeza'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'vomito_excesivo': vomitoExcesivo,
      'sangrado_vaginal': sangradoVaginal,
      'fiebre': fiebre,
      'hinchazon': hinchazon,
      'dolor_cabeza': dolorCabeza,
    };
  }

  SenalesPeligroModel copyWith({
    bool? vomitoExcesivo,
    bool? sangradoVaginal,
    bool? fiebre,
    bool? hinchazon,
    bool? dolorCabeza,
  }) {
    return SenalesPeligroModel(
      vomitoExcesivo: vomitoExcesivo ?? this.vomitoExcesivo,
      sangradoVaginal: sangradoVaginal ?? this.sangradoVaginal,
      fiebre: fiebre ?? this.fiebre,
      hinchazon: hinchazon ?? this.hinchazon,
      dolorCabeza: dolorCabeza ?? this.dolorCabeza,
    );
  }
}
