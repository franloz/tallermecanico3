import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/photo.dart';

class PhotoController {
  final user = FirebaseAuth.instance.currentUser!;//usuario actual para buscar en base de datos en base a él
  Future insert(String urlDownload, String matricula, String formattedDate) async{
    try{
    final docphoto=FirebaseFirestore.instance.collection('fotos').doc();//instancia de firebase

    final photo=Photo(
      idfirebase:docphoto.id,
      userid: user.uid,
      url: urlDownload,
      matricula: matricula,
      nombreimagen: formattedDate,
    );//creamos objeto

    final json=photo.toJson();//se da formato json

    await docphoto.set(json);//se inserta

    } on FirebaseException catch (e) {
        print(e);
      }

  }
  
 Future deletePhoto(String idfirebase, String nombreimagen) async {

   try{
      final docphoto = FirebaseFirestore.instance.collection('fotos').doc(idfirebase);

      docphoto.delete();//borro de firestore



      final storageRef = FirebaseStorage.instance.ref();//instancia del storage de firebase
      final desertRef = storageRef.child("fotos/${nombreimagen}");//obtengo la imagen 

      // Delete the file
      await desertRef.delete();//borro de storage la imagen

    } on FirebaseException catch (e) {
        print(e);
    }
  }


}
