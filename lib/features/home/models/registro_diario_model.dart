import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroDiarioModel {
  final String tipo;
  final DateTime fecha;

  // Campos madre
  final int? estadoAnimo;
  final int? nivelEstres;
  final int? horasSuenoMadre;
  final List<String>? sintomas;
  final int? presionSistolica;
  final int? presionDiastolica;
  final double? horasSueno;
  final int? vasosAgua;

  // Lactancia
  final bool? lactanciaMaterna;
  final int? tomasLactancia;

  // Bebé
  final int? movimientosFetales;
  final String? pesoBebe;
  final double? temperaturaBebe;
  final int? panalesMojados;
  final int? deposiciones;
  final String? colorDeposicion;
  final double? horasSuenoBebe;

  // Suplementos
  final bool? vitaminasPrenatales;
  final bool? hierro;

  // Alertas y notas
  final bool hayAlerta;
  final bool hayAlertaMadre;
  final bool hayAlertaBebe;
  final String? notas;
  final List<Map<String, dynamic>>? alertasActivadas;

  RegistroDiarioModel({
    required this.tipo,
    required this.fecha,
    this.estadoAnimo,
    this.nivelEstres,
    this.horasSuenoMadre,
    this.sintomas,
    this.presionSistolica,
    this.presionDiastolica,
    this.horasSueno,
    this.vasosAgua,
    this.lactanciaMaterna,
    this.tomasLactancia,
    this.movimientosFetales,
    this.pesoBebe,
    this.temperaturaBebe,
    this.panalesMojados,
    this.deposiciones,
    this.colorDeposicion,
    this.horasSuenoBebe,
    this.vitaminasPrenatales,
    this.hierro,
    required this.hayAlerta,
    required this.hayAlertaMadre,
    required this.hayAlertaBebe,
    this.notas,
    this.alertasActivadas,
  });

  factory RegistroDiarioModel.fromFirestore(Map<String, dynamic> json) {
    return RegistroDiarioModel(
      tipo: json['tipo'] ?? 'embarazo',
      fecha: (json['fecha'] as Timestamp).toDate(),
      estadoAnimo: json['estado_animo'],
      nivelEstres: json['nivel_estres'],
      horasSuenoMadre: json['horas_sueno_madre'],
      sintomas: json['sintomas'] != null
          ? List<String>.from(json['sintomas'])
          : null,
      presionSistolica: json['presion_sistolica'],
      presionDiastolica: json['presion_diastolica'],
      horasSueno: json['horas_sueno'] != null
          ? (json['horas_sueno'] as num).toDouble()
          : null,
      vasosAgua: json['vasos_agua'],
      lactanciaMaterna:
          json['lactancia_exclusiva'] ?? json['lactancia_materna'],
      tomasLactancia: json['tomas_lactancia'],
      movimientosFetales: json['movimientos_fetales'],
      pesoBebe: json['peso_bebe'] ?? json['peso'],
      temperaturaBebe: json['temperatura_bebe'] != null
          ? (json['temperatura_bebe'] as num).toDouble()
          : null,
      panalesMojados: json['panales_mojados'],
      deposiciones: json['deposiciones'],
      colorDeposicion: json['color_deposicion'],
      horasSuenoBebe: json['horas_sueno_bebe'] != null
          ? (json['horas_sueno_bebe'] as num).toDouble()
          : null,
      vitaminasPrenatales: json['vitaminas_prenatales'],
      hierro: json['hierro'],
      hayAlerta: json['hay_alerta'] ?? false,
      hayAlertaMadre: json['hay_alerta_madre'] ?? false,
      hayAlertaBebe: json['hay_alerta_bebe'] ?? false,
      notas: json['notas'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "tipo": tipo,
      "fecha": fecha,

      // Madre
      "estado_animo": estadoAnimo,
      "nivel_estres": nivelEstres,
      "horas_sueno_madre": horasSuenoMadre,
      "sintomas": sintomas,
      "presion_sistolica": presionSistolica,
      "presion_diastolica": presionDiastolica,
      "horas_sueno": horasSueno,
      "vasos_agua": vasosAgua,

      // Lactancia
      "lactancia_materna": lactanciaMaterna,
      "tomas_lactancia": tomasLactancia,

      // Bebé
      "movimientos_fetales": movimientosFetales,
      "peso_bebe": pesoBebe,
      "temperatura_bebe": temperaturaBebe,
      "panales_mojados": panalesMojados,
      "deposiciones": deposiciones,
      "color_deposicion": colorDeposicion,
      "horas_sueno_bebe": horasSuenoBebe,

      // Suplementos
      "vitaminas_prenatales": vitaminasPrenatales,
      "hierro": hierro,

      // Alertas
      "hay_alerta": hayAlerta,
      "hay_alerta_madre": hayAlertaMadre,
      "hay_alerta_bebe": hayAlertaBebe,

      // Notas
      "notas": notas,
      "alertas_activadas": alertasActivadas,
      "updated_at": Timestamp.now(),
    };
  }
}
