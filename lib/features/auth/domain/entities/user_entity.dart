class UserEntity {
  final String uid;
  final String nombres;
  final String apellidos;
  final String dni;
  final String? celular;
  final String? email;
  final int edad;
  final bool haDadoLuz;
  final int? semanasEmbarazo;
  final DateTime? fechaAproxParto;
  final DateTime? fechaNacimientoBebe;
  final String? tipoParto;
  final bool? complicaciones;
  final bool? lactanciaExclusiva;
  final int escalaEmocional;

  UserEntity({
    required this.uid,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    this.celular,
    this.email,
    required this.edad,
    required this.haDadoLuz,
    this.semanasEmbarazo,
    this.fechaAproxParto,
    this.fechaNacimientoBebe,
    this.tipoParto,
    this.complicaciones,
    this.lactanciaExclusiva,
    required this.escalaEmocional,
  });
}
