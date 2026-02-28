enum SexoBebe { masculino, femenino }

enum TipoAlimentacion { pecho, mixto, artificial }

class DatosBebeModel {
  final SexoBebe sexoBebe;
  final double pesoAlNacer;
  final double altura;
  final String? patologias;
  final TipoAlimentacion tipoAlimentacion;
  final bool? lactanciaExclusiva;

  DatosBebeModel({
    required this.sexoBebe,
    required this.pesoAlNacer,
    required this.altura,
    this.patologias,
    required this.tipoAlimentacion,
    this.lactanciaExclusiva,
  });

  static T enumFromString<T>(Iterable<T> values, String? name, T fallback) {
    return values.firstWhere(
      (e) => (e as dynamic).name == name,
      orElse: () => fallback,
    );
  }

  factory DatosBebeModel.fromFirestore(Map<String, dynamic> json) {
    return DatosBebeModel(
      sexoBebe: enumFromString(
        SexoBebe.values,
        json['sexo_bebe'],
        SexoBebe.masculino,
      ),
      pesoAlNacer: (json['peso_al_nacer'] as num?)?.toDouble() ?? 0.0,
      altura: (json['altura'] as num?)?.toDouble() ?? 0.0,
      patologias: json['patologias'] as String?,
      tipoAlimentacion: enumFromString(
        TipoAlimentacion.values,
        json['tipo_alimentacion'],
        TipoAlimentacion.pecho,
      ),
      lactanciaExclusiva: json['lactancia_exclusiva'] as bool?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sexo_bebe': sexoBebe.name,
      'peso_al_nacer': pesoAlNacer,
      'altura': altura,
      'patologias': patologias,
      'tipo_alimentacion': tipoAlimentacion.name,
      'lactancia_exclusiva': lactanciaExclusiva,
    };
  }

  DatosBebeModel copyWith({
    SexoBebe? sexoBebe,
    double? pesoAlNacer,
    double? altura,
    String? patologias,
    TipoAlimentacion? tipoAlimentacion,
    bool? lactanciaExclusiva,
  }) {
    return DatosBebeModel(
      sexoBebe: sexoBebe ?? this.sexoBebe,
      pesoAlNacer: pesoAlNacer ?? this.pesoAlNacer,
      altura: altura ?? this.altura,
      patologias: patologias ?? this.patologias,
      tipoAlimentacion: tipoAlimentacion ?? this.tipoAlimentacion,
      lactanciaExclusiva: lactanciaExclusiva ?? this.lactanciaExclusiva,
    );
  }
}
