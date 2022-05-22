import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/spare.dart';

class FirebaseDatabase {
  Future insertSpare(BuildContext context, Spare spare) async {
    int repetido = 0;

    try {

      final sparedoc =
          await FirebaseFirestore.instance.collection('spare').get();

      sparedoc.docs.forEach(//con este bucle recorremos la tabla spare para comprobar si existe la marca y la pieza que vamos a insertar si existe avisa al usuario y no la inserta
        (doc) {

          if (spare.marca == doc.data()['marca'] &&
              spare.pieza == doc.data()['pieza']) {
            repetido++;
          }
        },
      );

      if (repetido == 0) {
        final docSpare = FirebaseFirestore.instance.collection('spare').doc();
        spare.id = docSpare.id; //le asigno el id que genere firebase

        final json = spare.toJson();
        await docSpare.set(json);
        print('insertadoooooooooooo');
      } else {
        String error = 'Este recambio ya existe';
        DialogError dialogError = DialogError();
        dialogError.dialogError(context, error);
      }
    } on FirebaseException catch (e) {
      String error = 'Error al insertar';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future deleteSpare(String id)async {
    
    final docSpare = FirebaseFirestore.instance.collection('spare').doc(id);

    docSpare.delete();

  }


}
