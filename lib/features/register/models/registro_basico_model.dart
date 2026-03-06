class RegistroBasicoModel {
  final String? uid;
  final String fullname;
  final String dni;
  final String email;
  final String celular;
  final String? celularConfianza;
  final int edad;
  final String departamento;
  final String provincia;
  final String distrito;
  final String? photoUrl;

  RegistroBasicoModel({
    this.uid,
    required this.fullname,
    required this.dni,
    required this.email,
    required this.celular,
    this.celularConfianza,
    required this.edad,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    this.photoUrl,
  });

  factory RegistroBasicoModel.fromFirestore(Map<String, dynamic> json) {
    return RegistroBasicoModel(
      uid: json['uid'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      dni: json['dni'] as String? ?? '',
      email: json['email'] as String? ?? '',
      celular: json['celular'] as String? ?? '',
      celularConfianza: json['celular_confianza'] as String?,
      edad: json['edad'] as int? ?? 0,
      departamento: json['departamento'] as String? ?? '',
      provincia: json['provincia'] as String? ?? '',
      distrito: json['distrito'] as String? ?? '',
      photoUrl: json['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fullname': fullname,
      'dni': dni,
      'email': email,
      'celular': celular,
      'celular_confianza': celularConfianza,
      'edad': edad,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
      'photo_url': photoUrl,
    };
  }

  RegistroBasicoModel copyWith({
    String? uid,
    String? fullname,
    String? dni,
    String? email,
    String? celular,
    String? celularConfianza,
    int? edad,
    String? departamento,
    String? provincia,
    String? distrito,
    String? photoUrl,
  }) {
    return RegistroBasicoModel(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      dni: dni ?? this.dni,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      celularConfianza: celularConfianza ?? this.celularConfianza,
      edad: edad ?? this.edad,
      departamento: departamento ?? this.departamento,
      provincia: provincia ?? this.provincia,
      distrito: distrito ?? this.distrito,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
