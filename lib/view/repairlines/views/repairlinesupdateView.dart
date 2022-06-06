import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controller/repairlinecontroller.dart';

class RepairLinesUpdateView extends StatefulWidget {
  const RepairLinesUpdateView({Key? key}) : super(key: key);

  @override
  State<RepairLinesUpdateView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairLinesUpdateView> {
  RepairLineController cr=RepairLineController();

  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla

    String idorden = parametros!["idorden"];
    String idlinea = parametros["idlinea"];
    String idrecambio = parametros["idrecambio"];

    TextEditingController cantidadtxt = TextEditingController();
    cantidadtxt = parametros["cantidadtxt"];
    int cantidadold = parametros["cantidadold"];

    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Actualizar línea'),
        ),
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]{0,1}[0-9]*')),],
                      controller:  cantidadtxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Cantidad",
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
                TextButton(
                  onPressed: () async {
                    int cantidadnew = int.parse(cantidadtxt.text);

                    await cr.updateLine(context, idorden, idlinea, idrecambio,
                        cantidadold, cantidadnew);

                    cantidadtxt.clear();

                    Navigator.of(context).pop();
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
