import 'package:cloud_firestore/cloud_firestore.dart';

class EmbarazoActualModel {
  final DateTime ultimaMestruacion;
  final double? pesoActual;
  final double? altura;
  final bool controlPrenatal;
  final int? numeroControlesPrenatales;

  EmbarazoActualModel({
    required this.ultimaMestruacion,
    this.pesoActual,
    this.altura,
    required this.controlPrenatal,
    this.numeroControlesPrenatales,
  });

  static DateTime parseDate(dynamic value) {
    if (value == null) return DateTime.now(); // fallback
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    return DateTime.now();
  }

  factory EmbarazoActualModel.fromFirestore(Map<String, dynamic> json) {
    return EmbarazoActualModel(
      ultimaMestruacion: parseDate(json['ultima_mestruacion']),
      pesoActual: (json['peso_actual'] as num?)?.toDouble(),
      altura: (json['altura'] as num?)?.toDouble(),
      controlPrenatal: json['control_prenatal'] ?? false,
      numeroControlesPrenatales: (json['numero_controles_prenatales'] as num?)
          ?.toInt(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ultima_mestruacion': ultimaMestruacion.toIso8601String(),
      'peso_actual': pesoActual,
      'altura': altura,
      'control_prenatal': controlPrenatal,
      'numero_controles_prenatales': numeroControlesPrenatales,
    };
  }

  EmbarazoActualModel copyWith({
    DateTime? ultimaMestruacion,
    double? pesoActual,
    double? altura,
    bool? controlPrenatal,
    int? numeroControlesPrenatales,
  }) {
    return EmbarazoActualModel(
      ultimaMestruacion: ultimaMestruacion ?? this.ultimaMestruacion,
      pesoActual: pesoActual ?? this.pesoActual,
      altura: altura ?? this.altura,
      controlPrenatal: controlPrenatal ?? this.controlPrenatal,
      numeroControlesPrenatales:
          numeroControlesPrenatales ?? this.numeroControlesPrenatales,
    );
  }
}
