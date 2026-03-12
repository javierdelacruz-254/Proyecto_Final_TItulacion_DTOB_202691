class CentroSalud {
  final String nombre;
  final String distrito;
  final String tipo;
  final List<String> servicios;
  final String direccion;
  final String telefono;
  final double lat;
  final double lng;
  final String horario;

  CentroSalud({
    required this.nombre,
    required this.distrito,
    required this.tipo,
    required this.servicios,
    required this.direccion,
    required this.telefono,
    required this.lat,
    required this.lng,
    this.horario = "Lunes a Viernes: 8:00 am - 5:00 pm",
  });
}