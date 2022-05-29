import 'package:flutter/material.dart';
import 'package:tallermecanico/main.dart';

//esta clase se usará para los alertdialog que se deban llamar desde las clases controladoras
class DialogError {
  

  Future dialogError(BuildContext context, String error) =>
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey[600],
              title: const Text('Atención'),
              content: Text(error),
              actions: <Widget>[
                TextButton(
                  onPressed: () {Navigator.of(context).pop();
                  },  //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                  child: const Text(
                      'Ok'), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ));
  

  


}
