class RegistroBasicoModel {
  final String? uid;
  final String fullname;
  final String dni;
  final String? email;
  final String? celular;
  final int edad;
  final String departamento;
  final String provincia;
  final String distrito;
  final String institucion;
  final String photoUrl;

  RegistroBasicoModel({
    this.uid,
    required this.fullname,
    required this.dni,
    this.email,
    this.celular,
    required this.edad,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    required this.institucion,
    required this.photoUrl,
  });

  factory RegistroBasicoModel.fromFirestore(Map<String, dynamic> json) {
    return RegistroBasicoModel(
      uid: json['uid'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      dni: json['dni'] as String? ?? '',
      email: json['email'] as String?,
      celular: json['celular'] as String?,
      edad: json['edad'] as int? ?? 0,
      departamento: json['departamento'] as String? ?? '',
      provincia: json['provincia'] as String? ?? '',
      distrito: json['distrito'] as String? ?? '',
      institucion: json['institucion'] as String? ?? '',
      photoUrl: json['photo_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fullname': fullname,
      'dni': dni,
      'email': email,
      'celular': celular,
      'edad': edad,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
      'institucion': institucion,
      'photo_url': photoUrl,
    };
  }

  RegistroBasicoModel copyWith({
    String? uid,
    String? fullname,
    String? dni,
    String? email,
    String? celular,
    int? edad,
    String? departamento,
    String? provincia,
    String? distrito,
    String? institucion,
    String? photoUrl,
  }) {
    return RegistroBasicoModel(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      dni: dni ?? this.dni,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      edad: edad ?? this.edad,
      departamento: departamento ?? this.departamento,
      provincia: provincia ?? this.provincia,
      distrito: distrito ?? this.distrito,
      institucion: institucion ?? this.institucion,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
