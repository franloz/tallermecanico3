import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/vehicle.dart';
import 'package:tallermecanico/model/client.dart';


class DialogVehicles {
  DatabaseSqlite dt = DatabaseSqlite();

  /*TextEditingController matriculatxt = TextEditingController();
  TextEditingController marcatxt = TextEditingController();
  TextEditingController modelotxt =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña



  String? cli;*/


  

 /* Future dialogVehicleInsert(BuildContext context, Size size, List<String> lista) => showDialog(
    
      context: context,
      barrierDismissible: false,
      builder: (context) =>StatefulBuilder(builder: ((context, setState) =>  AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Añadir vehículo', style: TextStyle(color: Colors.white)),
            
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
                                  Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                controller:
                                    matriculatxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromARGB(255, 0, 229, 255)),
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
                                    marcatxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromARGB(255, 0, 229, 255)),
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

                                

                                controller:
                                    modelotxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromARGB(255, 0, 229, 255)),
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
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [Container(
                          
                          width: size.width /
                                1.4,
                          child:
                          DropdownButton<String>(
                            isExpanded: true,
                            hint:Text('Elige cliente'),
                            value: cli,
                            items: lista.map((item)=>DropdownMenuItem<String>(
                              value:item,
                              child: Text(item) ,
                            )).toList(),
                            onChanged: (item)=>setState(()=>cli=item),
                            
                            )
                          
                       
                      )]
                            
                            
                                   
                        
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
                              if (matriculatxt.text.isEmpty ||
                                  marcatxt.text.isEmpty ||
                                  modelotxt.text.isEmpty ||
                                  cli==null
                                 ) {
                                String error =
                                    'Rellene todos los campos antes de guardar';
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

                                await dt.insertVehicle(context, vehicle);

                                matriculatxt.clear();
                                marcatxt.clear();
                                modelotxt.clear();
                                //cli='Elige cliente';

                                Navigator.of(context).pop();
                              }
                            }, 
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
          )),));*/

/*  Future dialogVehicleUpdate(
          BuildContext context,
          Size size,
          String matricula,
          TextEditingController marca,
          TextEditingController modelo,
          String? dnicliente,
           List<String> lista) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>StatefulBuilder(builder: ((context, setState) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Actualizar Vehículo',
                    style: TextStyle(color: Colors.white)),
                //content: Text(error),
                actions: <Widget>[
                  Container(
                      width: size.width / 1,
                      child: Column(
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
                            onChanged: (item)=>setState(()=>dnicliente=item),
                            
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
                                      modelo.text.isEmpty //||
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
//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

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
                      ))
                ],
              )),));*/

  Future dialogVehicleDelete(BuildContext context, String dni) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar vehícule', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este vehículo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await dt.deleteVehicle(context,dni);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));



  /*DropdownMenuItem<String> getdropdown(String item)=>
    DropdownMenuItem(value:item, child: Text(item),);*/

        
  

  
    
}