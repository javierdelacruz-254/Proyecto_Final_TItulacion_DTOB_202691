import 'package:cloud_firestore/cloud_firestore.dart';

enum SexoBebe { masculino, femenino }

enum TipoAlimentacion { pecho, mixto, artificial }

enum TipoParto { natural, cesaria, asistido, otros }

class DatosBebeModel {
  final bool fuePrematuro;
  final TipoParto tipoParto;
  final DateTime fechaNacimientoBebe;
  final SexoBebe sexoBebe;
  final double pesoAlNacer;
  final double alturaAlNacer;
  final String? patologias;
  final TipoAlimentacion tipoAlimentacion;
  final bool? lactanciaExclusiva;

  DatosBebeModel({
    required this.fuePrematuro,
    required this.tipoParto,
    required this.fechaNacimientoBebe,
    required this.sexoBebe,
    required this.pesoAlNacer,
    required this.alturaAlNacer,
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

  static DateTime parseDate(dynamic value) {
    if (value == null) return DateTime.now(); // fallback
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    return DateTime.now();
  }

  factory DatosBebeModel.fromFirestore(Map<String, dynamic> json) {
    return DatosBebeModel(
      fuePrematuro: json['fue_prematuro'] as bool? ?? false,
      tipoParto: enumFromString(
        TipoParto.values,
        json['tipo_parto'],
        TipoParto.natural,
      ),
      fechaNacimientoBebe: parseDate(json['fecha_nacimiento_bebe']),
      sexoBebe: enumFromString(
        SexoBebe.values,
        json['sexo_bebe'],
        SexoBebe.masculino,
      ),
      pesoAlNacer: (json['peso_al_nacer'] as num?)?.toDouble() ?? 0.0,
      alturaAlNacer: (json['altura_al_nacer'] as num?)?.toDouble() ?? 0.0,
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
      'fue_prematuro': fuePrematuro,
      'tipo_parto': tipoParto.name,
      'fecha_nacimiento_bebe': fechaNacimientoBebe,
      'sexo_bebe': sexoBebe.name,
      'peso_al_nacer': pesoAlNacer,
      'altura_al_nacer': alturaAlNacer,
      'patologias': patologias,
      'tipo_alimentacion': tipoAlimentacion.name,
      'lactancia_exclusiva': lactanciaExclusiva,
    };
  }

  DatosBebeModel copyWith({
    bool? fuePrematuro,
    TipoParto? tipoParto,
    DateTime? fechaNacimientoBebe,
    SexoBebe? sexoBebe,
    double? pesoAlNacer,
    double? alturaAlNacer,
    String? patologias,
    TipoAlimentacion? tipoAlimentacion,
    bool? lactanciaExclusiva,
  }) {
    return DatosBebeModel(
      fuePrematuro: fuePrematuro ?? this.fuePrematuro,
      tipoParto: tipoParto ?? this.tipoParto,
      fechaNacimientoBebe: fechaNacimientoBebe ?? this.fechaNacimientoBebe,
      sexoBebe: sexoBebe ?? this.sexoBebe,
      pesoAlNacer: pesoAlNacer ?? this.pesoAlNacer,
      alturaAlNacer: alturaAlNacer ?? this.alturaAlNacer,
      patologias: patologias ?? this.patologias,
      tipoAlimentacion: tipoAlimentacion ?? this.tipoAlimentacion,
      lactanciaExclusiva: lactanciaExclusiva ?? this.lactanciaExclusiva,
    );
  }
}
