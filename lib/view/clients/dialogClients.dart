import 'package:flutter/material.dart';

class DialogClients {
  TextEditingController dni = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController telf =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController direccion = TextEditingController();

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
                                      dni, //se identifica el controlador del TextField
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
                                      hintText: "cliente",
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
                                      nombre, //se identifica el controlador del TextField
                                  obscureText: true,
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
                                      hintText: "Coche",
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
                                      telf, //se identifica el controlador del TextField
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
                                      hintText: "cliente",
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
                                      direccion, //se identifica el controlador del TextField
                                  obscureText: true,
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
                                      hintText: "Password",
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
                              onPressed: () {}, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                              child:  Text(
                                  'Guardar',style: TextStyle(
                                      fontSize: size.height / 35,
                                      color: Colors.white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                            ),
                          ],
                        ),

                        
                      ],
                    ))
              ],
            ));
  }
}
