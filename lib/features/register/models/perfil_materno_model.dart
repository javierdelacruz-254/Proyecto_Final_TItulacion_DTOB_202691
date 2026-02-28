enum NivelEducacion { ninguno, primaria, secundaria, universitaria }

enum EstadoCivil { casada, conviviente, soltera, otros }

enum RhSangre { positivo, negativo }

class PerfilMaternoModel {
  final EstadoCivil estadoCivil;
  final String direccion;
  final NivelEducacion nivelEducacion;
  final int? educacionAprobados;
  final bool sabeLeer;
  final String grupoSangre;
  final RhSangre rh;
  final String? ocupacion;
  final String? seguroSalud;

  PerfilMaternoModel({
    required this.estadoCivil,
    required this.direccion,
    required this.nivelEducacion,
    this.educacionAprobados,
    required this.sabeLeer,
    required this.grupoSangre,
    required this.rh,
    this.ocupacion,
    this.seguroSalud,
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
      direccion: json['direccion'] as String? ?? '',
      nivelEducacion: enumFromString(
        NivelEducacion.values,
        json['nivel_educacion'],
        NivelEducacion.ninguno,
      ),
      educacionAprobados: json['educacion_aprobados'] as int?,
      sabeLeer: json['sabe_leer'] ?? true,
      grupoSangre: json['grupo_sangre'] as String? ?? '',
      rh: enumFromString(RhSangre.values, json['rh'], RhSangre.positivo),
      ocupacion: json['ocupacion'] as String?,
      seguroSalud: json['seguro_salud'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'estado_civil': estadoCivil.name,
      'direccion': direccion,
      'nivel_educacion': nivelEducacion.name,
      'educacion_aprobados': educacionAprobados,
      'sabe_leer': sabeLeer,
      'grupo_sangre': grupoSangre,
      'rh': rh.name,
      'ocupacion': ocupacion,
      'seguro_salud': seguroSalud,
    };
  }

  PerfilMaternoModel copyWith({
    EstadoCivil? estadoCivil,
    String? direccion,
    NivelEducacion? nivelEducacion,
    int? educacionAprobados,
    bool? sabeLeer,
    String? grupoSangre,
    RhSangre? rh,
    String? ocupacion,
    String? seguroSalud,
  }) {
    return PerfilMaternoModel(
      estadoCivil: estadoCivil ?? this.estadoCivil,
      direccion: direccion ?? this.direccion,
      nivelEducacion: nivelEducacion ?? this.nivelEducacion,
      educacionAprobados: educacionAprobados ?? this.educacionAprobados,
      sabeLeer: sabeLeer ?? this.sabeLeer,
      grupoSangre: grupoSangre ?? this.grupoSangre,
      rh: rh ?? this.rh,
      ocupacion: ocupacion ?? this.ocupacion,
      seguroSalud: seguroSalud ?? this.seguroSalud,
    );
  }
}
