import 'package:flutter/material.dart';
import 'package:tallermecanico/main.dart';


class DialogsLogin {
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

  void dialogSignUp(BuildContext context, String error) {
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
                    Navigator.of(context).pop();
                  }, //regresa dos pantallas atras q serian el alertdialog y el circularprogress, están son las dos pantallas
                  child: const Text(
                      'Ok'), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ));
  }

  void dialogForgotPasswordIncorrect(BuildContext context, String error) {
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
                    Navigator.of(context).pop();
                  }, //regresa dos pantallas atras q serian el alertdialog y el circularprogress, están son las dos pantallas
                  child: const Text(
                      'Ok'), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ));
  } ////////////////////////////////////////////////unir estos dos metodos en uno con una condición

  void dialogForgotPasswordCorrect(BuildContext context, String error) {
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
                  }, //regresa dos pantallas atras q serian el alertdialog y el circularprogress, están son las dos pantallas
                  child: const Text(
                      'Ok'), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ));
  }

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
