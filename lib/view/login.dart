import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/logincontroller.dart';

class Login extends StatelessWidget {
  TextEditingController emailController =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    LoginController cr =
        LoginController(); //me creo una variable de la clase LoginController para usar los métodos que hay en ella
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, //para que la columna ocupe toda la pantalla
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,

              children: [
                Container(
                  width: size.width /
                      1.5, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)), //bordes circulares
                    color: Color.fromARGB(255, 0, 229, 255),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.car_repair_sharp,
                        size: size.height / 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("Gestión",
                                  style: TextStyle(
                                      fontSize: size.height / 35,
                                      color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Automovilística",
                                  style: TextStyle(
                                      fontSize: size.height / 35,
                                      color: Colors.white)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 20,
            ), //para separar rows

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
                          emailController, //se identifica el controlador del TextField
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
            ), //para separar rows

            Row(
              //fila con un container y un TextField para contraseña
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
                          passwordController, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.password),
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ), //para separar rows

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.lock_open_rounded), //icono del candado
                  label: Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: size.height / 30, color: Colors.white),
                  ),
                  onPressed: () {
                    cr.signIn(emailController, passwordController);
                  }, //se lanza el metodo de iniciar sesión al pulsar el botón
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
            )
          ],
        ),
      ),
    );
  }
}
