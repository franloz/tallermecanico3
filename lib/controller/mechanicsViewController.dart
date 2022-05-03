import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tallermecanico/mechanic.dart';

class MechanicsViewController {
  //final user = FirebaseAuth.instance.currentUser!; //usuario actual
  
  Future insert(String nom,String ape,double preci,String direcci)async {
    //referencia al documento

    final meca= FirebaseFirestore.instance.collection('mecanicos').doc();

    final mecanii=Mechanic(
      id:meca.id,
      nombre:nom,
      apellidos:ape,
      direccion:direcci,
      //preciohora:preci,

    );
    final json =mecanii.toJson();

    //crear documento y escribir datos en firebase
    await meca.set(json);

    /*FirebaseFirestore.instance
    .collection('mecanicos')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["nombre"]);
        });
    });*/

  }


  



}
