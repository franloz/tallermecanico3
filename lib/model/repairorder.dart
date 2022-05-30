
class RepairOrder {
  final String id;
  final String vehiculo;
  final String mecanico;
  final String horasreparacion;
  final String preciohora;
  final String descripcionreparacion;
  final String inicio;
  final String fin;
  final int facturada;

  const RepairOrder(
      {required this.id,
      required this.vehiculo,
      required this.mecanico,
      required this.horasreparacion,
      required this.preciohora,
      required this.descripcionreparacion,
      required this.inicio,
      required this.fin,
      required this.facturada
      
      });

  Map<String, dynamic> toMap() {
    //coleccion de llaves y valores
    return {
      'id': id,
      'vehiculo': vehiculo,
      'mecanico': mecanico,
      'horasreparacion': horasreparacion,
      'preciohora': preciohora,
      'descripcionreparacion': descripcionreparacion,
      'inicio': inicio,
      'fin':fin,
      'facturada':facturada
    };
  }
}

