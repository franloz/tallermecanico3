import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
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
                //fila con un container y un TextField para contraseña
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
                        //controller:
                        //passwordController, //se identifica el controlador del TextField
                        obscureText: true,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
            ]),
      ),
    );
  }
}
