import 'package:cloud_firestore/cloud_firestore.dart';

enum TipoParto { natural, cesaria, asistido, otros }

enum NivelAtencion { nivel1, nivel2, nivel3, domicilio, otros }

class RecienNacidoModel {
  final int edadGestacional;
  final TipoParto tipoParto;
  final NivelAtencion nivelAtencion;
  final String atendidoPor;
  final DateTime fechaNacimientoBebe;
  final bool desgarros;
  final bool placentaCompleta;

  RecienNacidoModel({
    required this.edadGestacional,
    required this.tipoParto,
    required this.nivelAtencion,
    required this.atendidoPor,
    required this.fechaNacimientoBebe,
    required this.desgarros,
    required this.placentaCompleta,
  });

  static T enumFromString<T>(Iterable<T> values, String? name, T fallback) {
    return values.firstWhere(
      (e) => (e as dynamic).name == name,
      orElse: () => fallback,
    );
  }

  static DateTime parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  factory RecienNacidoModel.fromFirestore(Map<String, dynamic> json) {
    return RecienNacidoModel(
      edadGestacional: json['edad_gestacional'] as int? ?? 0,
      tipoParto: enumFromString(
        TipoParto.values,
        json['tipo_parto'],
        TipoParto.natural,
      ),
      nivelAtencion: enumFromString(
        NivelAtencion.values,
        json['nivel_atencion'],
        NivelAtencion.nivel1,
      ),
      atendidoPor: json['atendido_por'] as String? ?? '',
      fechaNacimientoBebe: parseDate(json['fecha_nacimiento_bebe']),
      desgarros: json['desgarros'] as bool? ?? false,
      placentaCompleta: json['placenta_completa'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'edad_gestacional': edadGestacional,
      'tipo_parto': tipoParto.name,
      'nivel_atencion': nivelAtencion.name,
      'atendido_por': atendidoPor,
      'fecha_nacimiento_bebe': fechaNacimientoBebe.toIso8601String(),
      'desgarros': desgarros,
      'placenta_completa': placentaCompleta,
    };
  }

  RecienNacidoModel copyWith({
    int? edadGestacional,
    TipoParto? tipoParto,
    NivelAtencion? nivelAtencion,
    String? atendidoPor,
    DateTime? fechaNacimientoBebe,
    bool? desgarros,
    bool? placentaCompleta,
  }) {
    return RecienNacidoModel(
      edadGestacional: edadGestacional ?? this.edadGestacional,
      tipoParto: tipoParto ?? this.tipoParto,
      nivelAtencion: nivelAtencion ?? this.nivelAtencion,
      atendidoPor: atendidoPor ?? this.atendidoPor,
      fechaNacimientoBebe: fechaNacimientoBebe ?? this.fechaNacimientoBebe,
      desgarros: desgarros ?? this.desgarros,
      placentaCompleta: placentaCompleta ?? this.placentaCompleta,
    );
  }
}
