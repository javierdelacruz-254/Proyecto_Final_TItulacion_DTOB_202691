class IndividualVacunaModel {
  final String id;
  final String nombre;
  final int dosis;
  final List<String>? protegeContra;
  final String? descripcion;
  final String? nota;
  final String articuloId;

  IndividualVacunaModel({
    required this.id,
    required this.nombre,
    required this.dosis,
    this.protegeContra,
    this.descripcion,
    this.nota,
    required this.articuloId,
  });

  factory IndividualVacunaModel.fromJson(Map<String, dynamic> json) {
    return IndividualVacunaModel(
      id: json['id'],
      nombre: json['nombre'],
      dosis: json['dosis'],
      protegeContra: json['protege_contra'] != null
          ? List<String>.from(json['protege_contra'])
          : null,
      descripcion: json['descripcion'],
      nota: json['nota'],
      articuloId: json['articuloId'],
    );
  }
}
