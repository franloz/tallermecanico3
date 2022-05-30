
class Spare {
  final String id;
  final String marca;
  final String pieza;
  final String precio;
  final int stock;
  final int telfproveedor;

  const Spare(
      {required this.id,
      required this.marca,
      required this.pieza,
      required this.precio,
      required this.stock,
      required this.telfproveedor
      
      });

  Map<String, dynamic> toMap() {
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

