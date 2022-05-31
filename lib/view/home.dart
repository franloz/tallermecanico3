import 'package:flutter/material.dart';
import 'package:tallermecanico/alertdialog/dialogSignoff.dart';

class Home extends StatelessWidget {
  

  DialogSignOff dialog=DialogSignOff();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 229, 255),
        title: Text("Utilidades"),
        
        actions: <Widget>[
         
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async{

                  await dialog.dialogSignOff(
                                        context);


                },
                child: Icon(Icons.arrow_downward_outlined),
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment
            .center, //elementos de la columna centrados verticalmente
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            children: [
              ElevatedButton(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Clientes",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                  ],
                ),

                onPressed: () {
                  Navigator.pushNamed(context, 'ClientsView');
                }, //se lanza la actividad de clientes
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.boy,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Mecánicos",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'MechanicsView');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 255, 200, 0),
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
                          Icons.directions_car,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Vehículos",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'VehiclesView');
                }, //se lanza la actividad de vehículos
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 3, 232, 49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.build,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Recambios",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'SpareView');
                }, //se lanza la actividad de recambios
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 0, 132, 255),
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
                          "Órdenes",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Reparación",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    )
                  ],
                ),

                onPressed: () {
                  Navigator.pushNamed(context, 'RepairordersView');
                }, //se lanza la actividad de Órdenes de reparación
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 111, 0, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.euro,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Facturas",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  
                  Navigator.pushNamed(context, 'BillsView');
                }, //se lanza la actividad de Facturas
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 255, 123, 0),
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
                          Icons.camera_alt_sharp,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Fotos de",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "vehículos",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'VehiclePhotosView');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 0, 255, 68),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.euro,
                          size: size.height / 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Facturas",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'BillsView');
                }, //se lanza la actividad de Facturas
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      size.width / 2.3,
                      size.height /
                          6.7), //ancho y alto del boton en relación a la pantalla
                  primary: Color.fromARGB(255, 255, 123, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
