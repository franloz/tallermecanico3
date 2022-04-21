import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/homecontroller.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController cr =
        HomeController(); //me creo una variable de la clase HomeController para usar los métodos que hay en ella y sus variables
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicación"),
      ),
      body: Column(
        children: [
          Text("Aplicaciónnnnnnnnnnnnnn"),
          Text(cr.user.email! /*muestra el gmail del usuario actual*/),
        ],
      ),
    );
  }
}
