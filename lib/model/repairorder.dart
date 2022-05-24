class RepairOrder {
  String numeroorden;
  final String vehiculo;
  final String mecanico;
  final String horasdedicadas;
  final String descripcionreparacion;
  final String fechainicio;
  final String fechafin;

  RepairOrder(
      {this.numeroorden = '',
      required this.vehiculo,
      required this.mecanico,
      required this.horasdedicadas,
      required this.descripcionreparacion,
      required this.fechainicio,
      required this.fechafin});

  Map<String, dynamic> toJson() {
    //coleccion de llaves y valores
    return {
      'numeroorden': numeroorden,
      'vehiculo': vehiculo,
      'mecanico': mecanico,
      'horasdedicadas': horasdedicadas,
      'descripcionreparacion': descripcionreparacion,
      'fechainicio': fechainicio,
      'fechafin': fechafin,
    };
  }
}
