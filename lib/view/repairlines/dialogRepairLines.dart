import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/repairLines.dart';
import 'package:tallermecanico/model/repairorder.dart';
import 'package:uuid/uuid.dart';

class DialogRepairLine {
 // TextEditingController cantidadtxt = TextEditingController();

  DatabaseSqlite dt = DatabaseSqlite();

 // String? recambio; //values combobox

  /*Future dialogRepairLinesInsert(BuildContext context, Size size,
          List<String> listarecambios, String idorden) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(
              builder: ((context, setState) => AlertDialog(
                    backgroundColor: Colors.grey[600],
                    title: Text('Añadir Línea',
                        style: TextStyle(color: Colors.white)),
                    //content: Text(error),
                    actions: <Widget>[
                      Container(
                          width: size.width / 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                      width: size.width / 1.4,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('Elige recambio'),
                                        value: recambio,
                                        items: listarecambios
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item),
                                                ))
                                            .toList(),
                                        onChanged: (item) =>
                                            setState(() => recambio = item),
                                      ))
                                  //se convierte la lista de String a DropdownMenuItem<String>
                                ],
                              ),

                              const SizedBox(
                                height: 8,
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
                                          Radius.circular(
                                              20)), //bordes circulares
                                      color: Colors.grey[700],
                                    ),
                                    child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]{0,1}[0-9]*')),
                                        ],
                                        controller:
                                            cantidadtxt, //se identifica el controlador del TextField
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 0, 229, 255)),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.circle_outlined),
                                            border: InputBorder.none,
                                            hintText: "Cantidad",
                                            hintStyle: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ), //para separar rows
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      if (recambio == null ||
                                            cantidadtxt.text.isEmpty) {
                                          String error =
                                              'Debe elegir el recambio y la cantidad';
                                          DialogError dialogError =
                                              DialogError();
                                          await dialogError.dialogError(
                                              context, error);
                                        } else {
                                          //var fechahoy=DateTime.now();
                                          //String hoy = DateFormat('yyyy-MM-dd HH:mm:ss').format(fechahoy);

                                          String idlinea = idorden +
                                              '||' +
                                              recambio.toString();
                                          String recambiotx =
                                              recambio.toString();
                                          int cantidadtx =
                                              int.parse(cantidadtxt.text);

                                          var line = RepairLines(
                                            idorden: idorden,
                                            idlinea: idlinea,
                                            idrecambio: recambiotx,
                                            cantidad: cantidadtx,
                                          );
//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

                                          await dt.insertLines(context, line,
                                              recambiotx, cantidadtx);

                                          cantidadtxt.clear();

                                          //matriculavehi =
                                          // 'Elige vehículo'; //restauro los combobox
                                          // dnimeca = 'Elige mecánico';
                                          //inicio='Inicio';//restauro los botones de fechas
                                          // fin='Fin';

                                          
                                        }
                                      Navigator.of(context).pop();
                                    }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                    child: Text('Guardar',
                                        style: TextStyle(
                                            fontSize: size.height / 35,
                                            color: Colors
                                                .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ))));*/

  Future dialogLineUpdate(
          BuildContext context,
          Size size,
          String idorden,
          String idlinea,
          String idrecambio,
          TextEditingController cantidadtxt,
          int cantidadold) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(
              builder: ((context, setState) => AlertDialog(
                    backgroundColor: Colors.grey[600],
                    title: Text('Actualizar Línea',
                        style: TextStyle(color: Colors.white)),
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
                                          Radius.circular(
                                              20)), //bordes circulares
                                      color: Colors.grey[700],
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]{0,1}[0-9]*')),
                                        ],
                                        controller:
                                            cantidadtxt, //se identifica el controlador del TextField
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 0, 229, 255)),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.circle_outlined),
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
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      int cantidadnew =
                                            int.parse(cantidadtxt.text);

                                        await dt.updateLine(
                                            context,
                                            idorden,
                                            idlinea,
                                            idrecambio,
                                            cantidadold,
                                            cantidadnew);

                                        cantidadtxt.clear();
                                      
                                      Navigator.of(context).pop();
                                    },
                                    //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                    child: Text('Guardar',
                                        style: TextStyle(
                                            fontSize: size.height / 35,
                                            color: Colors
                                                .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ))));

  Future dialogOrderDelete(BuildContext context, String idorden, String idlinea,
          String idrecambio, int cantidad) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title:
                    Text('Borrar Línea', style: TextStyle(color: Colors.white)),
                content: Text('¿Estas seguro de borrar esta línea?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await dt.deleteLines(
                            idorden, idlinea, idrecambio, cantidad);

                     
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));

  Future<DateTime?> pickDateStart(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2200));
  Future<DateTime?> pickDateEnd(BuildContext context, DateTime datestart) =>
      showDatePicker(
          context: context,
          initialDate: datestart,
          firstDate: datestart,
          lastDate: DateTime(2200));
}
