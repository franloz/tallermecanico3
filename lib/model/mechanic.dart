class Mechanic{
  String id;
  String nombre;
  String apellidos;
  String direccion;
  //double preciohora;

  Mechanic({
    this.id='',
    required this.nombre,
    required this.apellidos,
    required this.direccion,
    //required this.preciohora,



  });

  Map<String, dynamic> toJson()=>{

    'id':id,
    'nombre':nombre,
    'apellidos':apellidos,
    'direccion':direccion,
    //'preciohora':preciohora,


  };


  static Mechanic fromJson(Map<String,dynamic>json)=>Mechanic(
    id: json['id'], 
    nombre: json['nombre'], 
    apellidos: json['apellidos'], 
    direccion: json['direccion'], );
    //preciohora:  (json["preciohora"] as double) .toDouble(), );

}