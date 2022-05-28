class RepairOrder {
  final String idorden;
  final String baseimponible;
  final String descuento;
  final String iva;
  final String totalfactura;
  

  RepairOrder(
      {
      required this.idorden,
      required this.baseimponible,
      required this.descuento,
      required this.iva,
      required this.totalfactura,
      });

  Map<String, dynamic> toJson() {
    //coleccion de llaves y valores
    return {
      'idorden': idorden,
      'baseimponible': baseimponible,
      'descuento': descuento,
      'iva': iva,
      'totalfactura': totalfactura,
      
    };
  }
}