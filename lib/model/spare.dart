
class Spare {
  String id;
  final String marca;
  final String pieza;
  final double precio;
  final int stock;
  final int telfproveedor;

   Spare(
      {
      this.id='',
      required this.marca,
      required this.pieza,
      required this.precio,
      required this.stock,
      required this.telfproveedor
      
      });

  Map<String, dynamic> toJson() {
    //coleccion de llaves y valores
    return {
      'id': id,
      'marca': marca,
      'pieza': pieza,
      'precio': precio,
      'stock': stock,
      'telfproveedor': telfproveedor,
    };
  }
}