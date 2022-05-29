import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';

class DialogClientsDelete {
  DatabaseSqlite dt = DatabaseSqlite();

  /*TextEditingController dnitxt = TextEditingController();
  TextEditingController nombretxt = TextEditingController();
  TextEditingController telftxt =TextEditingController(); 
  TextEditingController direcciontxt = TextEditingController();*/

  /*Future dialogClientInsert(BuildContext context, Size size) => showDialog(
      context: context,
      barrierDismissible: false,//para que no se cierre si toca en la pantalla
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:Text('Añadir Cliente', style: TextStyle(color: Colors.white)),
            
            actions: <Widget>[
              Container(
                  width: size.width / 1,
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
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
                        height: 6,
                      ), //para separar rows

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
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
                        height: 6,
                      ), //para separar rows

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
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
                        height: 6,
                      ), //para separar rows

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
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
                        height: 6,
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

                                await dt.insertClient(context, cliente);//se insertan los datos

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
                  ))
            ],
          ));*/

 /* Future dialogClientUpdate(
          BuildContext context,
          Size size,
          String dni,
          TextEditingController name,
          TextEditingController tlf,
          TextEditingController direction) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Actualizar Cliente',
                    style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  Container(
                      width: size.width / 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    controller:name, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all( Radius.circular(20)),
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
                            height: 6,
                          ), //para separar rows

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    keyboardType: TextInputType.number,///para que el teclado sea numerico
                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),], //para que no se puedan poner puntos o comas
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
                            height: 6,
                          ), //para separar rows

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
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
                                        hintStyle:TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 6,
                          ), //para separar rows

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            children: [
                              TextButton(
                                onPressed: () async{
                                  if (
                                      name.text.isEmpty ||
                                          tlf.text.isEmpty ||
                                          direction.text.isEmpty) {
                                    String error ='Rellene todos los campos antes de guardar';
                                    DialogError dialogError = DialogError();
                                    await dialogError.dialogError(context, error);
                                  } else {
                                    String nombre = name.text;
                                    int telf = int.parse(tlf.text);
                                    String direccion = direction.text;

                                    var cliente = Client(
                                      dni: dni,
                                      nombre: nombre,
                                      telf: telf,
                                      direccion: direccion,
                                    );

                                    await dt.updateClient(context, cliente, dni);//metodo que actualiza
                                    dnitxt.clear();
                                    nombretxt.clear();
                                    telftxt.clear();
                                    direcciontxt.clear();

                                    Navigator.of(context).pop();//se vuelve a pantalla anterior
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
                      ))
                ],
              ));*/

  Future dialogClientDelete(BuildContext context, String dni) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:Text('Borrar Cliente', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este cliente?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await dt.deleteClient(context, dni);//se borra
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
