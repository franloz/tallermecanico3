import 'package:flutter/material.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/vehicle.dart';

import '../../../controller/vehiclecontroller.dart';

class VehicleInsertView extends StatefulWidget {
  const VehicleInsertView({Key? key}) : super(key: key);

  @override
  State<VehicleInsertView> createState() => _ScreenState();
}

class _ScreenState extends State<VehicleInsertView> {
  VehicleController cr=VehicleController();

  TextEditingController matriculatxt = TextEditingController();
  TextEditingController marcatxt = TextEditingController();
  TextEditingController modelotxt = TextEditingController();

  String? cli;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
    List<String> lista = parametros!["lista"];
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Añadir vehículo'),
        ),
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
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
                      controller:
                          matriculatxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Matrícula",
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
                Container(
                  width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller: marcatxt, //se identifica el controlador del TextField
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
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
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
                      controller: modelotxt, //se identifica el controlador del TextField
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
                mainAxisAlignment: MainAxisAlignment .center, //Center Row contents horizontally,
                children: [
                  Container(
                      width: size.width / 1.1,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Elige cliente',
                            style: TextStyle(color: Colors.white)),
                        value: cli,
                        items: lista
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                        onChanged: (item) => setState(() => cli = item),
                      ))
                ]),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                TextButton(
                  onPressed: () async {
                    if (matriculatxt.text.isEmpty ||
                        marcatxt.text.isEmpty ||
                        modelotxt.text.isEmpty ||
                        cli == null) {
                      String error = 'Rellene todos los campos antes de guardar';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {
                      String matricula = matriculatxt.text;
                      String marca = marcatxt.text;
                      String modelo = modelotxt.text;

                      var vehicle = Vehicle(
                        matricula: matricula,
                        marca: marca,
                        modelo: modelo,
                        clientedni: cli.toString(),
                      );

                      await cr.insertVehicle(context, vehicle);

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Guardar',
                      style: TextStyle(
                          fontSize: size.height / 35, color: Colors.white)),
                ),
              ],
            ),
          ],
        ));
  }
}
