
class RepairLines {
  final String idorden;
  final String idlinea;
  final String idrecambio;
  final int cantidad;
 

  const RepairLines(
      {required this.idorden,
      required this.idlinea,
      required this.idrecambio,
      required this.cantidad,
      
      
      });

  Map<String, dynamic> toMap() {
    //coleccion de llaves y valores
    return {
      'idorden': idorden,
      'idlinea': idlinea,
      'idrecambio': idrecambio,
      'cantidad': cantidad,
      
      
    };
  }
}