enum NivelEducacion { ninguno, primaria, secundaria, universitaria }

enum EstadoCivil { casada, conviviente, soltera, otros }

enum RhSangre { positivo, negativo }

class PerfilMaternoModel {
  final EstadoCivil estadoCivil;
  final String grupoSangre;
  final RhSangre rh;
  final bool primerEmbarazo;
  final int? totalEmbarazos;
  final bool haDadoLuz;

  PerfilMaternoModel({
    required this.estadoCivil,
    required this.grupoSangre,
    required this.rh,
    required this.primerEmbarazo,
    this.totalEmbarazos,
    required this.haDadoLuz,
  });

  static T enumFromString<T>(Iterable<T> values, String? name, T fallback) {
    return values.firstWhere(
      (e) => (e as dynamic).name == name,
      orElse: () => fallback,
    );
  }

  factory PerfilMaternoModel.fromFirestore(Map<String, dynamic> json) {
    return PerfilMaternoModel(
      estadoCivil: enumFromString(
        EstadoCivil.values,
        json['estado_civil'],
        EstadoCivil.casada,
      ),
      grupoSangre: json['grupo_sangre'] as String? ?? '',
      rh: enumFromString(RhSangre.values, json['rh'], RhSangre.positivo),
      primerEmbarazo: json['primer_embarazo'] ?? false,
      totalEmbarazos: (json['total_embarazos'] as num?)?.toInt(),
      haDadoLuz: json['ha_dado_luz'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'estado_civil': estadoCivil.name,
      'grupo_sangre': grupoSangre,
      'rh': rh.name,
      'primer_embarazo': primerEmbarazo,
      'total_embarazos': totalEmbarazos,
      'ha_dado_luz': haDadoLuz,
    };
  }

  PerfilMaternoModel copyWith({
    EstadoCivil? estadoCivil,
    String? grupoSangre,
    RhSangre? rh,
    bool? primerEmbarazo,
    int? totalEmbarazos,
    bool? haDadoLuz,
  }) {
    return PerfilMaternoModel(
      estadoCivil: estadoCivil ?? this.estadoCivil,
      grupoSangre: grupoSangre ?? this.grupoSangre,
      rh: rh ?? this.rh,
      primerEmbarazo: primerEmbarazo ?? this.primerEmbarazo,
      totalEmbarazos: totalEmbarazos ?? this.totalEmbarazos,
      haDadoLuz: haDadoLuz ?? this.haDadoLuz,
    );
  }
}
