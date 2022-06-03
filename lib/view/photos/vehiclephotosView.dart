import 'package:flutter/material.dart';

class VehiclePhotosView extends StatefulWidget {
  const VehiclePhotosView({Key? key}) : super(key: key);

  @override
  State<VehiclePhotosView> createState() => _ScreenState();
}

class _ScreenState extends State<VehiclePhotosView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Fotos"),
              backgroundColor: Color.fromARGB(255, 0, 229, 255),
            ),
            backgroundColor: Colors.grey[800],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.upload,
                                size: size.height / 15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Subir",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 34),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "fotos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 34),
                              ),
                            ],
                          )
                        ],
                      ),

                      onPressed: () {
                       // Navigator.pushNamed(context, 'Repair_ordersView');
                      }, //se lanza la actividad de Ördenes de reparación
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            size.width / 2.3,
                            size.height /
                                6.7), //ancho y alto del boton en relación a la pantalla
                        primary: Color.fromARGB(255, 0, 145, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ), //para separar rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.assignment_sharp,
                                size: size.height / 15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Ver",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 34),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "fotos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 34),
                              ),
                            ],
                          )
                        ],
                      ),

                      onPressed: () {
                        Navigator.pushNamed(context, 'VehiclePhotosList');
                      }, //se lanza la actividad de Ördenes de reparación
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            size.width / 2.3,
                            size.height /
                                6.7), //ancho y alto del boton en relación a la pantalla
                        primary: Color.fromARGB(255, 43, 0, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
