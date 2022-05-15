/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/mechanicsViewController.dart';

import '../model/mechanic.dart';

class M extends StatelessWidget {
  TextEditingController nombre =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController apellidos = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController preciohora = TextEditingController();

  String nom = "";
  String ape = "";
  double preci = 0;
  String direcci = "";

  MechanicsViewController cr =
      MechanicsViewController(); //me creo una variable de la clase HomeController para usar los métodos que hay en ella y sus variables

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, //para que la columna ocupe toda la pantalla
          children: [
            Row(
              //fila con un container y un TextField para email
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /
                      1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:
                          nombre, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              //fila con un container y un TextField para email
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /
                      1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:
                          apellidos, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              //fila con un container y un TextField para email
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /
                      1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:
                          direccion, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              //fila con un container y un TextField para email
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /
                      1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:
                          preciohora, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.email_outlined), //icono del candado
                  label: Text(
                    "Cambiar contraseña",
                    style: TextStyle(
                        fontSize: size.height / 30, color: Colors.white),
                  ),
                  onPressed: () {
                    nom = nombre.text;
                    ape = apellidos.text;
                    preci = double.parse(preciohora.text);
                    ;
                    direcci = direccion.text;
                    cr.insert(nom, ape, preci, direcci);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        size.width / 1.1,
                        size.height /
                            16), //ancho y alto del boton en relación a la pantalla
                    primary: Color.fromARGB(255, 0, 229, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    ));
  }
}

Widget buildMeca(Mechanic me) => ListTile(
      leading: CircleAvatar(child: Text('${me.apellidos}')),
      title: Text(me.nombre),
      subtitle: Text('jb'),
    );*/
