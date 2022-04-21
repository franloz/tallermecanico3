import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  Future signIn(
      TextEditingController emailController,
      TextEditingController
          passwordController) //función asincrona para iniciar sesión
  async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          //se inicia sesión en FireBase con email y contraseña
          email: emailController.text.trim(),
          password: passwordController.text
              .trim()); //se usa trim para evitar los espacios en blanco
    } else {
      AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
      );
    }
  }
}
