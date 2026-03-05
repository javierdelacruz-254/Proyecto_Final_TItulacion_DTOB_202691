class CentroSalud {
  final String nombre;
  final String distrito;
  final String tipo;
  final List<String> servicios;
  final String direccion;
  final String telefono;
  final double lat;
  final double lng;

  CentroSalud({
    required this.nombre,
    required this.distrito,
    required this.tipo,
    required this.servicios,
    required this.direccion,
    required this.telefono,
    required this.lat,
    required this.lng,
  });
}