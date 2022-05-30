import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/repairLines.dart';
import 'package:tallermecanico/model/repairorder.dart';



class RepairLinesInsertView extends StatefulWidget {
  const RepairLinesInsertView({Key? key}) : super(key: key);

  @override
  State<RepairLinesInsertView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairLinesInsertView> {

 TextEditingController cantidadtxt = TextEditingController();

  DatabaseSqlite dt = DatabaseSqlite();

  String? recambio; //values combobox
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
    

   

    List<String> listarecambios= parametros!["listarecambios"];
    String idorden= parametros["idorden"];

   



 
    



    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Añadir línea'),),
      backgroundColor: Colors.grey[800],
      
      body: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                      width: size.width / 1.1,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('Elige recambio',style: TextStyle(
                                             color: Colors.white)),
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
                                    width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
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

                                           Navigator.of(context).pop();
                                        }
                                     
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
                          )
    );
  }


  
}
