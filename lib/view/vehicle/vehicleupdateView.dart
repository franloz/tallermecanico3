import 'package:flutter/material.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/vehicle.dart';



class VehicleUpdateView extends StatefulWidget {
  const VehicleUpdateView({Key? key}) : super(key: key);

  @override
  State<VehicleUpdateView> createState() => _ScreenState();
}

class _ScreenState extends State<VehicleUpdateView> {

  DatabaseSqlite dt = DatabaseSqlite();
  
  String? dnicliente;
  
  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
    TextEditingController marca= TextEditingController();
    TextEditingController modelo= TextEditingController();

    String matricula = parametros!["matricula"];
    marca=parametros["marcacontroll"];
    //dnicliente=parametros["clientedni"];
    modelo=parametros["modelocontroll"];

    List<String> lista=parametros["lista"];
    




        

    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Actualizar vehículo'),),
      backgroundColor: Colors.grey[800],
      
      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          

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
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    controller:
                                        marca, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Marca",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

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
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    

                                    ///para que el teclado sea numerico

                                    controller:
                                        modelo, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
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
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                             Container(
                          
                          width: size.width /
                                1.4,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dnicliente,
                            items: lista.map((item)=>DropdownMenuItem<String>(
                              value:item,
                              child: Text(item) ,
                            )).toList(),
                            onChanged: (item)=>setState((){dnicliente=item;print(item);print(dnicliente);}),
                            
                            ) )
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
                                onPressed: () async{
                                  if (/*matricula.text.isEmpty ||*/
                                      marca.text.isEmpty ||
                                      modelo.text.isEmpty ||dnicliente==null
                                      //cliente==''
                                      ) {
                                    String error ='Rellene todos los campos antes de guardar';
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

                                    await dt.updateVehicle(context, vehicle,
                                        matricula); //olddni para identificar que registro actualizo

                                    marca.clear();
                                    modelo.clear();
                                    //dnicliente.clear();

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
