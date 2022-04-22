import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/view/home.dart';
import 'package:tallermecanico/view/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //se inicializa FireBase de forma asincrona

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: StreamBuilder<User?>(
      //el stream permite recibir un flujo de datos el cual en este caso permite ver el estado del usuario en todo momento
      stream: FirebaseAuth.instance
          .authStateChanges(), //cada vez que el estado del usuario cambia (usuario loggeado o no)
      builder: (context, snapshot) {
        //cuando el stream cambia de valor(usuario loggeado o no) se llama a la siguiente condición
        if (snapshot.hasData) {
          //se comprueba si el usuario esta loggeado, si es asi, se dirige a la pantalla de Home sino a la de Login
          return Home();
        } else {
          return Login();
        }
      },
    ));
  }
}
