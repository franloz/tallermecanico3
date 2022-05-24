class RepairOrder {
  String numeroorden;
  final String vehiculo;
  final String mecanico;
  final double horasdedicadas;
  final String descripcionreparacion;
  final DateTime fechainicio;
  final DateTime fechafin;

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
