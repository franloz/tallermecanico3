class Client{

  final String dni;
  final String nombre;
  final int telf;
  final String direccion;

  const Client ({
    required  this.dni,
    required this.nombre,
    required this.telf,
    required this.direccion
  });
  
  Map<String, dynamic> toMap() {//coleccion de llaves y valores
    return {
      'dni': dni,
      'nombre': nombre,
      'telf': telf,
      'direccion': direccion,
    };
  }

  /*Client.fromMap(Map<String,dynamic> map){

  }*/



}