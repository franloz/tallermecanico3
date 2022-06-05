import 'package:flutter/material.dart';

import '../../controller/photocontroller.dart';


class DialogPhotoDelete {
  //FirebaseDatabase base = FirebaseDatabase();
  PhotoController cr=PhotoController();

  Future dialogPhotoDelete(BuildContext context, String idfirebase, String nombreimagen) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Borrar Imagen',
                    style: TextStyle(color: Colors.white)),
                content: Text('¿Estas seguro de borrar esta foto?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      cr.deletePhoto(idfirebase,nombreimagen);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
}
