import 'package:cloud_firestore/cloud_firestore.dart';

class EmbarazoActualModel {
  final DateTime? ultimaMestruacion;
  final DateTime? partoProbable;

  final double? pesoAntesEmbarazo;
  final double? pesoActual;
  final double? altura;

  final bool fuma;
  final int? cuantosCigarrillosAlDia;

  final bool controlPrenatal;
  final int? numeroControlesPrenatales;

  final bool dudasGenerales;

  EmbarazoActualModel({
    this.ultimaMestruacion,
    this.partoProbable,
    this.pesoAntesEmbarazo,
    this.pesoActual,
    this.altura,
    required this.fuma,
    this.cuantosCigarrillosAlDia,
    required this.controlPrenatal,
    this.numeroControlesPrenatales,
    required this.dudasGenerales,
  });

  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    return null;
  }

  factory EmbarazoActualModel.fromFirestore(Map<String, dynamic> json) {
    return EmbarazoActualModel(
      ultimaMestruacion: parseDate(json['ultima_mestruacion']),
      partoProbable: parseDate(json['parto_probable']),
      pesoAntesEmbarazo: (json['peso_antes_embarazo'] as num?)?.toDouble(),
      pesoActual: (json['peso_actual'] as num?)?.toDouble(),
      altura: (json['altura'] as num?)?.toDouble(),
      fuma: json['fuma'] ?? false,
      cuantosCigarrillosAlDia: (json['cuantos_cigarrillos_al_dia'] as num?)
          ?.toInt(),
      controlPrenatal: json['control_prenatal'] ?? false,
      numeroControlesPrenatales: (json['numero_controles_prenatales'] as num?)
          ?.toInt(),
      dudasGenerales: json['dudas_generales'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ultima_mestruacion': ultimaMestruacion?.toIso8601String(),
      'parto_probable': partoProbable?.toIso8601String(),
      'peso_antes_embarazo': pesoAntesEmbarazo,
      'peso_actual': pesoActual,
      'altura': altura,
      'fuma': fuma,
      'cuantos_cigarrillos_al_dia': cuantosCigarrillosAlDia,
      'control_prenatal': controlPrenatal,
      'numero_controles_prenatales': numeroControlesPrenatales,
      'dudas_generales': dudasGenerales,
    };
  }

  EmbarazoActualModel copyWith({
    DateTime? ultimaMestruacion,
    DateTime? partoProbable,
    double? pesoAntesEmbarazo,
    double? pesoActual,
    double? altura,
    bool? fuma,
    int? cuantosCigarrillosAlDia,
    bool? controlPrenatal,
    int? numeroControlesPrenatales,
    bool? dudasGenerales,
  }) {
    return EmbarazoActualModel(
      ultimaMestruacion: ultimaMestruacion ?? this.ultimaMestruacion,
      partoProbable: partoProbable ?? this.partoProbable,
      pesoAntesEmbarazo: pesoAntesEmbarazo ?? this.pesoAntesEmbarazo,
      pesoActual: pesoActual ?? this.pesoActual,
      altura: altura ?? this.altura,
      fuma: fuma ?? this.fuma,
      cuantosCigarrillosAlDia:
          cuantosCigarrillosAlDia ?? this.cuantosCigarrillosAlDia,
      controlPrenatal: controlPrenatal ?? this.controlPrenatal,
      numeroControlesPrenatales:
          numeroControlesPrenatales ?? this.numeroControlesPrenatales,
      dudasGenerales: dudasGenerales ?? this.dudasGenerales,
    );
  }
}
