import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/mechanicsViewController.dart';
//import 'package:transparent_image/transparent_image.dart';

import '../model/mechanic.dart';

class MechanicsView extends StatelessWidget {
  TextEditingController nombre =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController apellidos = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController preciohora = TextEditingController();

  String nom = "";
  String ape = "";
  double preci = 0;
  String direcci = "";

  MechanicsViewController cr =
      MechanicsViewController(); //me creo una variable de la clase HomeController para usar los métodos que hay en ella y sus variables

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
          child: TextField(controller:
                          nombre,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();//para esconder teclado, y refresca widget
                    //setState(() {});
                    //filtro='jj';
                    nom=nombre.text;
                    print('FloatingActionButton');
                  },
                ),
                hintText: 'Matrícula del coche',
                ),
          ),
        ),)),
        backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          child: Icon(Icons.add),
          onPressed: () {
            print('FloatingActionButton');
          }),
      body:
       Row(children: [
        Container(
            height: 900,
            width: 355,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                   FirebaseFirestore.instance.collection('fotos').where('matricula',isEqualTo:nom).snapshots(),
                   //FirebaseFirestore.instance.collection('fotos').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.hasError.toString());
                  }

                  

                    ///poner en otro sitio
                  
                  if (snapshot.hasData) {
                    final mecha = snapshot.data!;
                    //mecha.size.toString() tamaño de la lista, cuantos documentos ahi

                    /*return ListView.builder(
                          itemCount: tamano,
                          itemBuilder: (context, index) {

                              DocumentSnapshot documentSnapshot AsyncSnapshot<dynamic> snapshot snapshot.data.documents[index];
                            return Row(
                              children: [
                                Image.network(
                                  data['url'],
                                  height: 200,
                                  width: 200,
                                ),
                              ],
                            );
                          });*/

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        //String matricula = data['matricula'];
                        //String url = data['url'];

                        return SizedBox(height:200,child:ListTile(
                          onTap: () {
                            String v=data['url'];
                            print(v);//buscar lo escrito entre % y ?///////////////////////// o añadir otro campo a tabala





                          },
                          //horizontalTitleGap: 0.0,
                          leading: SizedBox(
                            height: 500.0,
                            width: 200.0, // fixed width and height
                            child: Stack(
                              children: <Widget>[
                                const Center(
                                    child: CircularProgressIndicator()),
                                    Column(children: [
                                Expanded(
                                  
                                  child: Image.network(
                                    data['url'],
                                    height: 700,
                                    width: 500,
                                  ),
                                ),],)
                              ],
                            ),
                          ),

                          dense: true,
                          visualDensity: VisualDensity(
                             vertical: 4, horizontal: 4), // to expand
                          //onTap: ,
                        ));
                      }).toList(),
                    );
                  } else {
                    return Column(
                      /*mainAxisAlignment: MainAxisAlignment
            .center,
                      //child: CircularProgressIndicator(),
                      children:[Text(
                          "Aquí se mostrarán las imágenes del vehículo",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        )]*/);
                    
                  }
                })),
      ]),
    ));
  }
}

Widget buildMeca(Mechanic me) => ListTile(
      leading: CircleAvatar(child: Text('${me.apellidos}')),
      title: Text(me.nombre),
      subtitle: Text('jb'),
    );

/*Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }*/
