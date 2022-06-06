import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/main.dart';
import 'package:tallermecanico/view/login/dialogslogin.dart';


class LoginController {
  DialogsLogin dialog = DialogsLogin(); //se crea objeto de la clase DialogsLogin para poder usar sus metodos

  Future signIn(TextEditingController emailController,TextEditingController passwordController,BuildContext context) //función asincrona para iniciar sesión
  async {
    dialog.dialogCircularProgress(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword( email: emailController.text.trim(),password: passwordController.text .trim()); //se usa trim para evitar los espacios en blanco
       //el await indica que esta parte del código es asincrona
       //se inicia sesión en FireBase con email y contraseña
      navigatorKey.currentState!.popUntil(((route) => route .isFirst)); //regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
      //esto nos permite eliminar el indicador de carga que se lanza en el login

    } on FirebaseAuthException catch (e) {
      String error = " "; //está variable se usará para capturar el texto de la excepción y mostrarsela al usuario

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        error = "Usuario no encontrado, si desea registrarse pulse sobre el botón Registrarse";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        error = "Contraseña incorrecta";
      } else {
        error = "Introduzca un gmail y contraseña válidos o no deje los campos vacios";
      }
      dialog.dialogSignIn(context, error); //se muestra alertdialog cuando no se inicie sesión

    }
  }



  Future signUp(TextEditingController emailController, TextEditingController passwordController,BuildContext context) //función asincrona para registro de usuario
  async {
    dialog.dialogCircularProgress(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword( email: emailController.text.trim(),password: passwordController.text.trim()); //se usa trim para evitar los espacios en blanco
      //el await indica que esta parte del código es asincrona
      //se registra en FireBase con email y contraseña
      navigatorKey.currentState!.popUntil(((route) =>route.isFirst)); //regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario

    } on FirebaseAuthException catch (e) {
      String error =" "; //está variable se usará para capturar el texto de la excepción y mostrarsela al usuario

      if (e.code == 'email-already-in-use') {
        error = "Este email ya es usado por un usario";
      } else if (e.code == 'weak-password') {
        error = "Contraseña demasiado débil";
      } else {
        error = "Introduzca un gmail y contraseña válidos o no deje los campos vacios";
      }
      dialog.dialogSignUp( context, error); //se muestra alertdialog cuando no se inicie sesión

    }
  }

  Future resetPassword( TextEditingController emailController, BuildContext context) //función asincrona para restaurrar contraseña
  async {
    String mensaje='';
    dialog.dialogCircularProgress(context);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail( email: emailController.text.trim());

          mensaje='Vaya a su gmail y podrá cambiar su contraseña';

          navigatorKey.currentState!.popUntil(((route) =>route.isFirst));

          dialog.dialogForgotPasswordCorrect(context,mensaje);

    } on FirebaseAuthException catch (e) {
      String error ='Ha ocurrido un error y no se ha cambiado la contraseña, revise su correo'; //está variable se usará para capturar el texto de la excepción y mostrarsela al usuario

      dialog.dialogForgotPasswordIncorrect(context, error); 

    }
  }
}
