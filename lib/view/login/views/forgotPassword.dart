import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/logincontroller.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    LoginController cr =LoginController();
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[800],
        body: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, //para que la columna ocupe toda la pantalla
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                children: [
                  Text(
                    "Introduzca su email",
                    style: TextStyle(
                        fontSize: size.height / 33, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                //fila con un container y un TextField para email
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.email_outlined), //icono del candado
                    label: Text(
                      "Cambiar contraseña",
                      style: TextStyle(
                          fontSize: size.height / 30, color: Colors.white),
                    ),
                    onPressed: () {cr.resetPassword(emailController,context);},
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
      ),
    );
  }
}
