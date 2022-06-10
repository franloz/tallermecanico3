import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/mechanic.dart';

import '../../../controller/mechaniccontroller.dart';

class MechanicUpdateView extends StatefulWidget {
  const MechanicUpdateView({Key? key}) : super(key: key);

  @override
  State<MechanicUpdateView> createState() => _ScreenState();
}

class _ScreenState extends State<MechanicUpdateView> {
  //DatabaseSqlite dt = DatabaseSqlite();
  MechanicController cr=MechanicController();


  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
    TextEditingController name = TextEditingController();
    TextEditingController tlf = TextEditingController();
    TextEditingController direction = TextEditingController();

    String dni = parametros!["dni"];
    name = parametros["namecontroll"];
    tlf = parametros["tlfcontroll"];
    direction = parametros["direccioncontroll"];

    final size = MediaQuery.of(context).size;
    return Scaffold(
       resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Actualizar mecánico'),
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
                  width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:name, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Nombre",
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
                  height: size.height / 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,///para que el teclado sea numerico
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow( RegExp(r'[0-9]{0,1}[0-9]*')), ], //para que no se puedan poner puntos o comas
                      controller:tlf, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Teléfono",
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
                  height: size.height / 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:direction, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Dirección",
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
                TextButton(
                  onPressed: () async {
                    if (name.text.isEmpty ||
                        tlf.text.isEmpty ||
                        direction.text.isEmpty) {//si los campos estan vacios
                      String error = 'Rellene todos los campos antes de guardar';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {
                      String nombre = name.text;
                      int telf = int.parse(tlf.text);
                      String direccion = direction.text;

                      var mechanic = Mechanic(
                        dni: dni,
                        nombre: nombre,
                        telf: telf,
                        direccion: direccion,
                      );

                      await cr.updateMechanic(context, mechanic, dni);//metodo para actualizar

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
