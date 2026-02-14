class AppUser {
  final String id;
  final String nombres;
  final String apellidos;
  final String dni;
  final int edad;
  final String? email;
  final String estadoEmbarazo;
  final DateTime? fechaPartoEstimado;
  final DateTime? fechaNacimientoBebe;
  final int? semanasEmbarazo;
  final String estado;

  AppUser({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.edad,
    this.email,
    required this.estadoEmbarazo,
    this.fechaPartoEstimado,
    this.fechaNacimientoBebe,
    this.semanasEmbarazo,
    required this.estado,
  });
}
