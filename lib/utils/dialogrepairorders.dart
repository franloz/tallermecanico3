import 'package:flutter/material.dart';
import 'package:tallermecanico/main.dart';

//esta clase se usará para los alertdialog que se deban llamar desde las clases controladoras
class DialogRepairOrders {
  void dialogCircularProgress(BuildContext context) {
    showDialog(
        //se muestra un cuadro de dialogo con un símbolo de carga
        context: context,
        barrierDismissible:
            false, //false para que al clicar sobre el dialog no tenga efecto
        builder: (context) => Center(child: CircularProgressIndicator()));
  }

  void dialogSignIn(BuildContext context, String error) {
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Atención'),
              content: Text(error),
              actions: <Widget>[
                TextButton(
                  onPressed: () => navigatorKey.currentState!.popUntil(
                      ((route) => route
                          .isFirst)), //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                  child: const Text(
                      'Ok'), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ));
  }

  


}
