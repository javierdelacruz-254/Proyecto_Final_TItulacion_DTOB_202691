import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilObstetricoModel {
  final bool primerEmbarazo;
  final int? totalEmbarazos;
  final int? abortos;
  final int? partosNaturales;
  final int? cesarias;
  final DateTime? ultimoEmbarazoAnterior;

  final bool haDadoLuz;

  PerfilObstetricoModel({
    required this.primerEmbarazo,
    this.totalEmbarazos,
    this.abortos,
    this.partosNaturales,
    this.cesarias,
    this.ultimoEmbarazoAnterior,
    required this.haDadoLuz,
  });

  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    return null;
  }

  factory PerfilObstetricoModel.fromFirestore(Map<String, dynamic> json) {
    return PerfilObstetricoModel(
      primerEmbarazo: json['primer_embarazo'] ?? false,
      totalEmbarazos: (json['total_embarazos'] as num?)?.toInt(),
      abortos: (json['abortos'] as num?)?.toInt(),
      partosNaturales: (json['partos_naturales'] as num?)?.toInt(),
      cesarias: (json['cesarias'] as num?)?.toInt(),
      ultimoEmbarazoAnterior: parseDate(json['ultimo_embarazo_anterior']),
      haDadoLuz: json['ha_dado_luz'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'primer_embarazo': primerEmbarazo,
      'total_embarazos': totalEmbarazos,
      'abortos': abortos,
      'partos_naturales': partosNaturales,
      'cesarias': cesarias,
      'ultimo_embarazo_anterior': ultimoEmbarazoAnterior?.toIso8601String(),
      'ha_dado_luz': haDadoLuz,
    };
  }

  PerfilObstetricoModel copyWith({
    bool? primerEmbarazo,
    int? totalEmbarazos,
    int? abortos,
    int? partosNaturales,
    int? cesarias,
    DateTime? ultimoEmbarazoAnterior,
    bool? haDadoLuz,
  }) {
    return PerfilObstetricoModel(
      primerEmbarazo: primerEmbarazo ?? this.primerEmbarazo,
      totalEmbarazos: totalEmbarazos ?? this.totalEmbarazos,
      abortos: abortos ?? this.abortos,
      partosNaturales: partosNaturales ?? this.partosNaturales,
      cesarias: cesarias ?? this.cesarias,
      ultimoEmbarazoAnterior:
          ultimoEmbarazoAnterior ?? this.ultimoEmbarazoAnterior,
      haDadoLuz: haDadoLuz ?? this.haDadoLuz,
    );
  }
}
