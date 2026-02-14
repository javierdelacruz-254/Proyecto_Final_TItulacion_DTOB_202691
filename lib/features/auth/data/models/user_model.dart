import 'package:lactaamor/features/auth/domain/entities/app_user.dart';

class UserModel extends AppUser {
  UserModel({
    required super.id,
    required super.nombres,
    required super.apellidos,
    required super.dni,
    required super.edad,
    super.email,
    required super.estadoEmbarazo,
    super.fechaPartoEstimado,
    super.fechaNacimientoBebe,
    super.semanasEmbarazo,
    required super.estado,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      dni: json['dni'],
      edad: json['edad'],
      email: json['email'],
      estadoEmbarazo: json['estado_embarazo'],
      fechaPartoEstimado: json['fecha_parto_estimado'] != null
          ? DateTime.parse(json['fecha_parto_estimado'])
          : null,
      fechaNacimientoBebe: json['fecha_nacimiento_bebe'] != null
          ? DateTime.parse(json['fecha_nacimiento_bebe'])
          : null,
      semanasEmbarazo: json['semanas_embarazo'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'dni': dni,
      'edad': edad,
      'email': email,
      'estado_embarazo': estadoEmbarazo,
      'fecha_parto_estimado': fechaPartoEstimado?.toIso8601String(),
      'fecha_nacimiento_bebe': fechaNacimientoBebe?.toIso8601String(),
      'semanas_embarazo': semanasEmbarazo,
      'estado': estado,
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
