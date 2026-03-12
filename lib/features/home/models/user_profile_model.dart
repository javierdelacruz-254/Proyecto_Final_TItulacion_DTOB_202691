import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String uid;
  final String fullname;
  final bool haDadoLuz;
  final DateTime? ultimaMenstruacion;
  final DateTime? fechaNacimientoBebe;
  final bool? anemiaGrave;
  final bool? lactanciaMaterna;
  final double? peso;
  final double? altura;

  UserProfileModel({
    required this.uid,
    required this.fullname,
    required this.haDadoLuz,
    this.ultimaMenstruacion,
    this.fechaNacimientoBebe,
    this.anemiaGrave,
    this.lactanciaMaterna,
    this.peso,
    this.altura,
  });

  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is Timestamp) return value.toDate();
    return null;
  }

  factory UserProfileModel.fromFirestore(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'],
      fullname: json['fullname'] ?? '',
      haDadoLuz: json['perfilMaterno']['ha_dado_luz'] ?? false,
      ultimaMenstruacion: parseDate(
        json['embarazoActual']?['ultima_mestruacion'],
      ),
      fechaNacimientoBebe: parseDate(
        json['datosBebe']?['fecha_nacimiento_bebe'],
      ),
      anemiaGrave: json['perfilMedico']?['anemiaGrave'] ?? false,
      lactanciaMaterna: json['datosBebe']?['lactancia_exclusiva'] ?? false,
      peso: json['datosBebe']?['peso_al_nacer'],
      altura: json['datosBebe']?['altura_al_nacer'],
    );
  }

  int get semanasEmbarazo {
    if (ultimaMenstruacion == null) return 0;
    return DateTime.now().difference(ultimaMenstruacion!).inDays ~/ 7;
  }

  int get semanasPostParto {
    if (fechaNacimientoBebe == null) return 0;
    return DateTime.now().difference(fechaNacimientoBebe!).inDays ~/ 7;
  }

  int get diasEmbarazo {
    if (ultimaMenstruacion == null) return 0;
    return DateTime.now().difference(ultimaMenstruacion!).inDays;
  }

  int get diasPostParto {
    if (fechaNacimientoBebe == null) return 0;
    return DateTime.now().difference(fechaNacimientoBebe!).inDays;
  }
}
