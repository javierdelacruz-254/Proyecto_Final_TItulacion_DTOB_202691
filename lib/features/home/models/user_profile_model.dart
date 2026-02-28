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

  factory UserProfileModel.fromFirestore(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'],
      fullname: json['fullname'] ?? String,
      haDadoLuz: json['perfilObstetrico']['ha_dado_luz'] ?? false,
      ultimaMenstruacion: json['embarazoActual']?['ultima_mestruacion'] != null
          ? DateTime.parse(json['embarazoActual']['ultima_mestruacion'])
          : null,
      fechaNacimientoBebe: json['recienNacido']?['fecha_nacimiento'] != null
          ? DateTime.parse(json['recienNacido']['fecha_nacimiento'])
          : null,
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
