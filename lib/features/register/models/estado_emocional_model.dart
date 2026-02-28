enum EstadoEmocional { bien, ansiosa, triste, asustada, abrumada }

class EstadoEmocionalModel {
  final EstadoEmocional estadoEmocionalActual;
  final int estadoEmocionalEscala;
  final bool violenciaDomestica;
  final bool accesoAgua;
  final String? nivelSocioEconomico;

  EstadoEmocionalModel({
    required this.estadoEmocionalActual,
    required this.estadoEmocionalEscala,
    required this.violenciaDomestica,
    required this.accesoAgua,
    this.nivelSocioEconomico,
  });

  static T enumFromString<T>(Iterable<T> values, String? name, T fallback) {
    return values.firstWhere(
      (e) => (e as dynamic).name == name,
      orElse: () => fallback,
    );
  }

  factory EstadoEmocionalModel.fromFirestore(Map<String, dynamic> json) {
    return EstadoEmocionalModel(
      estadoEmocionalActual: enumFromString(
        EstadoEmocional.values,
        json['estado_emocional_actual'],
        EstadoEmocional.bien,
      ),
      estadoEmocionalEscala: (json['estado_emocional_escala'] as int?) ?? 1,
      violenciaDomestica: json['violencia_domestica'] ?? false,
      accesoAgua: json['acceso_agua'] ?? true,
      nivelSocioEconomico: json['nivel_socio_economico'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'estado_emocional_actual': estadoEmocionalActual.name,
      'estado_emocional_escala': estadoEmocionalEscala,
      'violencia_domestica': violenciaDomestica,
      'acceso_agua': accesoAgua,
      'nivel_socio_economico': nivelSocioEconomico,
    };
  }

  EstadoEmocionalModel copyWith({
    EstadoEmocional? estadoEmocionalActual,
    int? estadoEmocionalEscala,
    bool? violenciaDomestica,
    bool? accesoAgua,
    String? nivelSocioEconomico,
  }) {
    return EstadoEmocionalModel(
      estadoEmocionalActual:
          estadoEmocionalActual ?? this.estadoEmocionalActual,
      estadoEmocionalEscala:
          estadoEmocionalEscala ?? this.estadoEmocionalEscala,
      violenciaDomestica: violenciaDomestica ?? this.violenciaDomestica,
      accesoAgua: accesoAgua ?? this.accesoAgua,
      nivelSocioEconomico: nivelSocioEconomico ?? this.nivelSocioEconomico,
    );
  }
}
