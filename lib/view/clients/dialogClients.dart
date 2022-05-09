import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/client.dart';

class DialogClients {
  TextEditingController dnitxt = TextEditingController();
  TextEditingController nombretxt = TextEditingController();
  TextEditingController telftxt =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController direcciontxt = TextEditingController();

  DatabaseSqlite dt = DatabaseSqlite();

  void dialogClient(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey[600],
              title:
                  Text('Añadir Cliente', style: TextStyle(color: Colors.white)),
              //content: Text(error),
              actions: <Widget>[
                Container(
                    width: size.width / 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          //fila con un container y un TextField para email
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          children: [
                            Container(
                              width: size.width /
                                  1.4, //ancho del TextField en relación al ancho de la pantalla
                              height: size.height / 17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)), //bordes circulares
                                color: Colors.grey[700],
                              ),
                              child: TextField(
                                  controller:
                                      dnitxt, //se identifica el controlador del TextField
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 0, 229, 255)),
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      border: InputBorder.none,
                                      hintText: "DNI",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ))),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ), //para separar rows

                        Row(
                          //fila con un container y un TextField para contraseña
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          children: [
                            Container(
                              width: size.width /
                                  1.4, //ancho del TextField en relación al ancho de la pantalla
                              height: size.height / 17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)), //bordes circulares
                                color: Colors.grey[700],
                              ),
                              child: TextField(
                                  controller:
                                      nombretxt, //se identifica el controlador del TextField
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 0, 229, 255)),
                                      ),
                                      prefixIcon: Icon(Icons.password),
                                      border: InputBorder.none,
                                      hintText: "Nombre",
                                      hintStyle:
                                          TextStyle(color: Colors.white))),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ), //para separar rows

                        Row(
                          //fila con un container y un TextField para email
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          children: [
                            Container(
                              width: size.width /
                                  1.4, //ancho del TextField en relación al ancho de la pantalla
                              height: size.height / 17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)), //bordes circulares
                                color: Colors.grey[700],
                              ),
                              child: TextField(
                                  controller:
                                      telftxt, //se identifica el controlador del TextField
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 0, 229, 255)),
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      border: InputBorder.none,
                                      hintText: "Teléfono",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ))),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ), //para separar rows

                        Row(
                          //fila con un container y un TextField para contraseña
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          children: [
                            Container(
                              width: size.width /
                                  1.4, //ancho del TextField en relación al ancho de la pantalla
                              height: size.height / 17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)), //bordes circulares
                                color: Colors.grey[700],
                              ),
                              child: TextField(
                                  controller:
                                      direcciontxt, //se identifica el controlador del TextField
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 0, 229, 255)),
                                      ),
                                      prefixIcon: Icon(Icons.password),
                                      border: InputBorder.none,
                                      hintText: "Dirección",
                                      hintStyle:
                                          TextStyle(color: Colors.white))),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ), //para separar rows

                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          children: [
                            TextButton(
                              onPressed: () {
                                String dni = dnitxt.text;
                                String nombre = nombretxt.text;
                                int telf = int.parse(telftxt.text);
                                String direccion = direcciontxt.text;

                                var cliente = Client(
                                  dni: dni,
                                  nombre: nombre,
                                  telf: telf,
                                  direccion: direccion,
                                );
//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre
                                int result = dt.insertClient(cliente) as int;
                                //print(result);
                                if (result != 0) {
                                  print('mano');
                                }
                                Navigator.of(context).pop();
                              }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                              child: Text('Guardar',
                                  style: TextStyle(
                                      fontSize: size.height / 35,
                                      color: Colors
                                          .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ));
  }
}
