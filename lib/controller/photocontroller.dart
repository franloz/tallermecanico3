import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/photo.dart';

class PhotoController {
  final user = FirebaseAuth.instance.currentUser!;
  Future insert(String urlDownload, String matricula, String formattedDate) async{
    try{
    final docphoto=FirebaseFirestore.instance.collection('fotos').doc();

    final photo=Photo(
      idfirebase:docphoto.id,
      userid: user.uid,
      url: urlDownload,
      matricula: matricula,
      nombreimagen: formattedDate,
    );

    final json=photo.toJson();

    await docphoto.set(json);

    } on FirebaseException catch (e) {
        print(e);
      }

  }
  
 Future deletePhoto(String idfirebase, String nombreimagen) async {

   try{
      final docphoto = FirebaseFirestore.instance.collection('fotos').doc(idfirebase);

      docphoto.delete();//borro de firestore



      final storageRef = FirebaseStorage.instance.ref();
      final desertRef = storageRef.child("fotos/${nombreimagen}");

      // Delete the file
      await desertRef.delete();//borro de storage la imagen

    } on FirebaseException catch (e) {
        print(e);
    }
  }


}
