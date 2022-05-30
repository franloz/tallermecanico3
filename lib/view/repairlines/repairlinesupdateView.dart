import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/client.dart';
import 'package:tallermecanico/model/mechanic.dart';
import 'package:tallermecanico/model/repairorder.dart';



class RepairLinesUpdateView extends StatefulWidget {
  const RepairLinesUpdateView({Key? key}) : super(key: key);

  @override
  State<RepairLinesUpdateView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairLinesUpdateView> {

  DatabaseSqlite dt = DatabaseSqlite();
  
  
          /*String idorden,
          String idlinea,
          String idrecambio,
          TextEditingController cantidadtxt,
          int cantidadold */
  
  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
   /* TextEditingController horasreparaciontxt= TextEditingController();
    TextEditingController preciohoratxt= TextEditingController();
    TextEditingController descripcionreparaciontxt= TextEditingController();

    horasreparaciontxt=parametros!["horasreparaciontxt"];
    preciohoratxt=parametros["preciohoratxt"];
    descripcionreparaciontxt=parametros["descripcionreparaciontxt"];

    List<String> listamecanicos=parametros["listamecanicos"];

    String idord=parametros["id"];
    String vehiculomatri=parametros["vehiculo"];
    String fechainicio=parametros["fechainicio"];
    String fin=parametros["fechafin"];



    String mecanicoactual=parametros["mecanico"];*/

    String idorden=parametros!["idorden"];
    String idlinea=parametros["idlinea"];
    String idrecambio=parametros["idrecambio"];

    TextEditingController cantidadtxt= TextEditingController();
    cantidadtxt=parametros["cantidadtxt"];
    int cantidadold=parametros["cantidadold"];


    

        

    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Actualizar línea'),),
      backgroundColor: Colors.grey[800],
      
      body: Column(
                            children: [
                              const SizedBox(
                                height: 20,
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
                          )
    );
  }

  
 
  
}
