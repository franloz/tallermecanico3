import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehiclePhotosList extends StatefulWidget {
  const VehiclePhotosList({Key? key}) : super(key: key);

  @override
  State<VehiclePhotosList> createState() => _ScreenState();
}

class _ScreenState extends State<VehiclePhotosList> {
  String search = '';
  TextEditingController searchtxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            child: Center(
              child: TextField(
                controller: searchtxt,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context)
                          .unfocus(); //para que el textfield pierda el foco

                      search = searchtxt.text;
                      setState(() {}); //para actualizar la vista
                    },
                  ),
                  hintText: 'Matrícula del coche a buscar',
                ),
              ),
            ),
          )),
      backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 229, 255),
            child: Icon(Icons.add),
            onPressed: () async {
              FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

              await Navigator.pushNamed(context, 'VehicleUploadPhotos');//con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate

              setState(() {});
            }),
      body: Row(children: [
        Container(
            height: size.height,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: loadList(),
                //FirebaseFirestore.instance.collection('fotos').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  ///poner en otro sitio


                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =document.data()! as Map<String, dynamic>;
                      //String matricula = data['matricula'];
                      String url = data['url'];
                      var i=null;

                      return miCardImageCarga(url, size,i);
                    }).toList(),
                  );
                })),
      ]),
    ));
  }

  Stream<QuerySnapshot> loadList() {
    if (search != '') {
      print(search.toUpperCase());
      return FirebaseFirestore.instance
          .collection('fotos') //.where("userid", isEqualTo: user.uid)
          .where('matricula', isEqualTo: search)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(
              'fotos').snapshots(); /*.where("userid", isEqualTo: user.uid)*/ 
    } //este where es para que muestre los datos del usuario loggeado
  }
}

Widget miCardImageCarga(String url, Size size, i) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  height: size.height / 2.8,
                  width: size.width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Center(
                    child: FittedBox(
                  child:i==null//si es nulo salta el icono, meter aqui si hay internet
                  ?Icon(Icons.abc)
                  
                  
                  
                  : CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    height: size.height / 2.5,
                    width: size.width,
                    placeholder: (context,url)=>Container(color: Colors.black12),
                   // errorWidget: (context,url,error)=>Container(
                     // color:Colors.black12,
                     // child:Icon(Icons.error,color:Colors.red),
                    //),
                  ),
                  /*Image.network(
                     
                    url,
                    fit: BoxFit.cover,
                    height: size.height/2.5,
                    width: size.width,
                  ),*/
                ))
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('Paisaje con carga'),
            )
          ],
        ),
      ));
}
