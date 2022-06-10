import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//alertdialog para cerrar sesión
class DialogSignOff {

  Future dialogSignOff(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
            content: Text('¿Desea cerrar sesión?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();//ir hacia atrás
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();//cerrar sesion
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
