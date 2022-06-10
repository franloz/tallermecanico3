import 'package:flutter/material.dart';
//alertdialog para mostrar errores
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
                  onPressed: () {Navigator.of(context).pop();//ir hacia atrás
                  },  
                  child: const Text(
                      'Ok'), 
                ),
              ],
            ));
  

  


}
