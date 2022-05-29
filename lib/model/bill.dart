
////firebase

class Bill {
  String id;
  final String idorden;
  final String baseimponible;
  final String descuento;
  final String iva;
  final String totalfactura;
  

  Bill(
      {
      this.id='',
      required this.idorden,
      required this.baseimponible,
      required this.descuento,
      required this.iva,
      required this.totalfactura,
      });

  Map<String, dynamic> toJson() {
    //coleccion de llaves y valores
    return {
      'id':id,
      'idorden': idorden,
      'baseimponible': baseimponible,
      'descuento': descuento,
      'iva': iva,
      'totalfactura': totalfactura,
      
    };
  }
}