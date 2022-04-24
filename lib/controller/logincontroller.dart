import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/utils/utils.dart';

class LoginController {

  Utils u=Utils();//se crea objeto de la clase Utils para poder usar sus metodos

  Future signIn(TextEditingController emailController,TextEditingController passwordController, BuildContext context) //función asincrona para iniciar sesión
  async {

    u.dialogCircularProgress(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(//el await indica que esta parte del código es asincrona
          //se inicia sesión en FireBase con email y contraseña
          email: emailController.text.trim(),
          password: passwordController.text.trim()
          ); //se usa trim para evitar los espacios en blanco
          Navigator.popUntil(context, (route) => route.isFirst);//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                                                 //esto nos permite eliminar el indicador de carga que se lanza en el login
    
    } on FirebaseAuthException catch (e) {
      
      String error=" ";//está variable se usará para capturar el texto de la excepción y mostrarsela al usuario

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        error="Usuario no encontrado, si desea registrarse pulse sobre el botón Registrarse";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        error="Contraseña incorrecta";
      } else {
        error="Introduzca un gmail y contraseña válidos o no deje los campos vacios";
      }
      u.dialogSignIn(context,error);//se muestra alertdialog cuando no se inicie sesión

    }on FlutterError catch (e){
      String error="Ha ocurrido un error en la conexión intentelo de nuevo";/////borrar estooooooooooooooooooooooooooooo seguramente           jhgggggggggggggg
      u.dialogSignIn(context,error);
    }
 
  }    

  Future signUp(TextEditingController emailController,TextEditingController passwordController, BuildContext context) //función asincrona para registro de usuario
  async {

    u.dialogCircularProgress(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(//el await indica que esta parte del código es asincrona
          //se registra en FireBase con email y contraseña
          email: emailController.text.trim(),
          password: passwordController.text.trim()
          ); //se usa trim para evitar los espacios en blanco
          Navigator.popUntil(context, (route) => route.isFirst);//regresa hasta la pantalla de LoginSignUp
                                                                 
    
    } on FirebaseAuthException catch (e) {
      
      String error=" ";//está variable se usará para capturar el texto de la excepción y mostrarsela al usuario

      if (e.code == 'email-already-in-use') {
        error="Este email ya es usado por un usario";
      } else if (e.code == 'weak-password') {
        error="Contraseña demasiado débil";
      } else {
        error="Introduzca un gmail y contraseña válidos o no deje los campos vacios";
      }
      u.dialogSignUp(context,error);//se muestra alertdialog cuando no se inicie sesión

    }
  }   
}                                                       

  













