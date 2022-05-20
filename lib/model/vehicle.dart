class Vehicle {
  final String matricula;
  final String marca;
  final String modelo;
  final String clientedni;

  const Vehicle(
      {required this.matricula,
      required this.marca,
      required this.modelo,
      required this.clientedni});

  Map<String, dynamic> toMap() {
    //coleccion de llaves y valores
    return {
      'matricula': matricula,
      'marca': marca,
      'modelo': modelo,
      'clientedni': clientedni,
    };
  }
}
