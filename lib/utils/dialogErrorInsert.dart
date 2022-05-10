import 'package:flutter/material.dart';
import 'package:tallermecanico/main.dart';

//esta clase se usará para los alertdialog que se deban llamar desde las clases controladoras
class DialogErrorInsert {
  void dialogErrorInsert(BuildContext context, String error) {
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Atención'),
              content: Text(error),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                      'Ok'), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ));
  }
}
