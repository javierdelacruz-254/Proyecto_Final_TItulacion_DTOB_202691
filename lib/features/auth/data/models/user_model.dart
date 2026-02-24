import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.nombres,
    required super.apellidos,
    required super.dni,
    super.celular,
    super.email,
    required super.edad,
    required super.haDadoLuz,
    super.semanasEmbarazo,
    super.fechaAproxParto,
    super.fechaNacimientoBebe,
    super.tipoParto,
    super.complicaciones,
    super.lactanciaExclusiva,
    required super.escalaEmocional,
  });

  factory UserModel.fromFirestoreUserModel(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      nombres: json['nombres'] as String? ?? '',
      apellidos: json['apellidos'] as String? ?? '',
      dni: json['dni'] as String? ?? '',
      celular: json['celular'] as String?,
      email: json['email'] as String?,
      edad: json['edad'] as int? ?? 0,
      haDadoLuz: json['ha_dado_luz'] as bool? ?? false,
      semanasEmbarazo: json['semanas_embarazo'] as int?,
      fechaAproxParto: json['fecha_aprox_parto'] != null
          ? (json['fecha_aprox_parto'] as Timestamp).toDate()
          : null,
      fechaNacimientoBebe: json['fecha_nacimiento_bebe'] != null
          ? (json['fecha_nacimiento_bebe'] as Timestamp).toDate()
          : null,
      tipoParto: json['tipo_parto'] as String?,
      complicaciones: json['complicaciones'] as bool?,
      lactanciaExclusiva: json['lactancia_exclusiva'] as bool?,
      escalaEmocional: json['escala_emocional'] as int? ?? 0,
    );
  }

  factory UserModel.fromFirebaseUser(fb.User user) {
    return UserModel(
      uid: user.uid,
      nombres: user.displayName ?? '',
      apellidos: '',
      dni: '',
      celular: user.phoneNumber,
      email: user.email,
      edad: 0,
      haDadoLuz: false,
      escalaEmocional: 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'nombres': nombres,
      'apellidos': apellidos,
      'dni': dni,
      'celular': celular,
      'email': email,
      'edad': edad,
      'ha_dado_luz': haDadoLuz,
      'semanas_embarazo': semanasEmbarazo,
      'fecha_aprox_parto': fechaAproxParto?.toIso8601String(),
      'fecha_nacimiento_bebe': fechaNacimientoBebe?.toIso8601String(),
      'tipo_parto': tipoParto,
      'complicaciones': complicaciones,
      'lactancia_exclusiva': lactanciaExclusiva,
      'escala_emocional': escalaEmocional,
      'estado': "enabled",
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? nombres,
    String? apellidos,
    String? dni,
    String? celular,
    String? email,
    int? edad,
    bool? haDadoLuz,
    int? semanasEmbarazo,
    DateTime? fechaAproxParto,
    DateTime? fechaNacimientoBebe,
    String? tipoParto,
    bool? complicaciones,
    bool? lactanciaExclusiva,
    int? escalaEmocional,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      dni: dni ?? this.dni,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      edad: edad ?? this.edad,
      haDadoLuz: haDadoLuz ?? this.haDadoLuz,
      semanasEmbarazo: semanasEmbarazo ?? this.semanasEmbarazo,
      fechaAproxParto: fechaAproxParto ?? this.fechaAproxParto,
      fechaNacimientoBebe: fechaNacimientoBebe ?? this.fechaNacimientoBebe,
      tipoParto: tipoParto ?? this.tipoParto,
      complicaciones: complicaciones ?? this.complicaciones,
      lactanciaExclusiva: lactanciaExclusiva ?? this.lactanciaExclusiva,
      escalaEmocional: escalaEmocional ?? this.escalaEmocional,
    );
  }
}
