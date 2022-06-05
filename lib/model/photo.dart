////firebase

class Photo {
  String idfirebase;
  final String userid;//para filtrar la información según usuario
  final String url;
  final String matricula;
  final String nombreimagen;
  
  

  Photo(
      {
      this.idfirebase='',
      required this.userid,
      required this.url,
      required this.matricula,
      required this.nombreimagen,
      
      });

  Map<String, dynamic> toJson() {
    //coleccion de llaves y valores
    return {
      'idfirebase':idfirebase,
      'userid': userid,
      'url': url,
      'matricula': matricula,
      'nombreimagen': nombreimagen,
      
      
    };
  }
}