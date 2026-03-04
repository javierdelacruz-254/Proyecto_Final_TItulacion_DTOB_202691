import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String uid;
  final String fullname;
  final bool haDadoLuz;
  final DateTime? ultimaMenstruacion;
  final DateTime? fechaNacimientoBebe;

  UserProfileModel({
    required this.uid,
    required this.fullname,
    required this.haDadoLuz,
    this.ultimaMenstruacion,
    this.fechaNacimientoBebe,
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
      haDadoLuz: json['perfilMedico']['ha_dado_luz'] ?? false,
      ultimaMenstruacion: parseDate(
        json['embarazoActual']?['ultima_mestruacion'],
      ),
      fechaNacimientoBebe: parseDate(
        json['datosBebe']?['fecha_nacimiento_bebe'],
      ),
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
}
