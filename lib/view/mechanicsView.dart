import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/mechanicsViewController.dart';

import '../mechanic.dart';

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
            backgroundColor: Colors.grey[800],
            body: Row(children: [Container(
              height: 400,
              width: 200,
              child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('mecanicos')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.hasError.toString());
                      }
                      if (snapshot.hasData) {
                        final mecha = snapshot.data!;
                        //mecha.size.toString() tamaño de la lista, cuantos documentos ahi

                        return ListView(
                          
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data =document.data()! as Map<String, dynamic>;
                                
                            return ListTile(
                              title: Text(mecha.size.toString()),//data.length.toString() devuelve el numero de campos 
                              //subtitle: Text(data['apellidos']),
                            );
                          }).toList(),
                        );


                        


                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              


            ),
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