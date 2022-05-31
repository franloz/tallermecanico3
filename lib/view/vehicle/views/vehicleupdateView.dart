import 'package:flutter/material.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/vehicle.dart';

import '../../../controller/vehiclecontroller.dart';

class VehicleUpdateView extends StatefulWidget {
  const VehicleUpdateView({Key? key}) : super(key: key);

  @override
  State<VehicleUpdateView> createState() => _ScreenState();
}

class _ScreenState extends State<VehicleUpdateView> {
 // DatabaseSqlite dt = DatabaseSqlite();
  VehicleController cr=VehicleController();

  String? dnicliente;

  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
    TextEditingController marca = TextEditingController();
    TextEditingController modelo = TextEditingController();

    String matricula = parametros!["matricula"];
    marca = parametros["marcacontroll"];
    String clienteactual = parametros["clientedni"];
    modelo = parametros["modelocontroll"];

    List<String> lista = parametros["lista"];

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Actualizar vehículo'),
        ),
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller: marca, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Marca",
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller: modelo, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Modelo",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Text('Cliente actual: ' + clienteactual,
                    style: TextStyle(
                        fontSize: size.height / 45, color: Colors.white))
              ],
            ),

            const SizedBox(
              height: 3,
            ), //para separar rows

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                    width: size.width / 1.1,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Elige cliente',style: TextStyle(  color: Colors.white)),
                      value: dnicliente,
                      items: lista
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => dnicliente = item),
                    ))
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                TextButton(
                  onPressed: () async {
                    if ( marca.text.isEmpty ||
                            modelo.text.isEmpty ||
                            dnicliente == null
                       
                        ) {
                      String error = 'Rellene todos los campos antes de guardar';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {
                      String marcaa = marca.text;
                      String modeloo = modelo.text;

                      var vehicle = Vehicle(
                        matricula: matricula,
                        marca: marcaa,
                        modelo: modeloo,
                        clientedni: dnicliente.toString(),
                      );

                      await cr.updateVehicle(context, vehicle, matricula); 

                      marca.clear();
                      modelo.clear();

                      Navigator.of(context).pop();
                    }
                  }, 
                  child: Text('Guardar',
                      style: TextStyle(
                          fontSize: size.height / 35,
                          color: Colors
                              .white)),
                ),
              ],
            ),
          ],
        ));
  }
}
