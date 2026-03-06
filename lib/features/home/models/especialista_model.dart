class Especialista {
  final String id;
  final String nombre;
  final String especializacion;
  final String descripcion;
  final String telefono;
  final String email;
  final String foto;

  Especialista({
    required this.id,
    required this.nombre,
    required this.especializacion,
    required this.descripcion,
    required this.telefono,
    required this.email,
    required this.foto,
  });

  factory Especialista.fromFirestore(
      String id, Map<String, dynamic> data) {
    return Especialista(
      id: id,
      nombre: data['nombre'] ?? '',
      especializacion: data['especializacion'] ?? '',
      descripcion: data['descripcion'] ?? '',
      telefono: data['telefono'] ?? '',
      email: data['email'] ?? '',
      foto: data['foto'] ?? '',
    );
  }
}