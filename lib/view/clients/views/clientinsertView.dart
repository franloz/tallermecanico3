import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/controller/clientcontroller.dart';
import 'package:tallermecanico/databases/database.dart';
import 'package:tallermecanico/model/client.dart';



class ClientInsertView extends StatefulWidget {
  const ClientInsertView({Key? key}) : super(key: key);

  @override
  State<ClientInsertView> createState() => _ScreenState();
}

class _ScreenState extends State<ClientInsertView> {

  //DatabaseSqlite dt = DatabaseSqlite();

  ClientController cr=ClientController();



  TextEditingController dnitxt = TextEditingController();
  TextEditingController nombretxt = TextEditingController();
  TextEditingController telftxt =TextEditingController(); 
  TextEditingController direcciontxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Añadir cliente'),),
      backgroundColor: Colors.grey[800],
      
      body: Column(
                    
                    children: [
                      SizedBox(
                        height: 20,
                      ), //para separar rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                controller:dnitxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "DNI",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ))),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 8,
                      ), //para separar rows

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                controller:nombretxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
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
                            width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                keyboardType: TextInputType.number,///para que el teclado sea numerico
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),], //para que no se puedan poner puntos o comas
                                controller:telftxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
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
                            width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                controller:direcciontxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
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
                            onPressed: () async{
                              if (dnitxt.text.isEmpty ||
                                  nombretxt.text.isEmpty ||
                                  telftxt.text.isEmpty ||
                                  direcciontxt.text.isEmpty) {//comprueba que los campos estén vacios
                                String error ='Rellene todos los campos antes de guardar';//si están vacios lanza un dialog comunicando que debe rellenarlos
                                DialogError dialogError = DialogError();
                                await dialogError.dialogError(context, error);
                              } else {
                                String dni = dnitxt.text;
                                String nombre = nombretxt.text;
                                int telf = int.parse(telftxt.text);
                                String direccion = direcciontxt.text;

                                var cliente = Client(//se crea un objeto cliente
                                  dni: dni,
                                  nombre: nombre,
                                  telf: telf,
                                  direccion: direccion,
                                );

                                await cr.insertClient(context, cliente);//se insertan los datos

                                dnitxt.clear();// se vacian los campos de texto
                                nombretxt.clear();
                                telftxt.clear();
                                direcciontxt.clear();

                                Navigator.of(context).pop();//se vuelve a la pantalla anterior
                              }
                            }, 
                            child: Text('Guardar',
                                style: TextStyle(
                                    fontSize: size.height / 35,
                                    color: Colors.white)), 
                          ),
                        ],
                      ),
                    ],
                  )
    );
  }

  

  
}
