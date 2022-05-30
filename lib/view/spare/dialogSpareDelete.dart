
import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';


class DialogSpareDelete {
 /* TextEditingController marcatxt = TextEditingController();
  TextEditingController piezatxt = TextEditingController();
  TextEditingController preciotxt =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController stocktxt = TextEditingController();
  TextEditingController telfproveedortxt = TextEditingController();*/

  DatabaseSqlite dt = DatabaseSqlite();

  /*Future dialogSpareInsert(BuildContext context, Size size) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Añadir Recambio', style: TextStyle(color: Colors.white)),
            //content: Text(error),
            actions: <Widget>[
              Container(
                  width: size.width / 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        //fila con un container y un TextField para email
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
                                controller:marcatxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Marca",
                                    hintStyle: TextStyle(color: Colors.white,
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
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                controller:piezatxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Pieza",
                                    hintStyle: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ), //para separar rows

                      Row(
                        //fila con un container y un TextField para email
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                ], //para que solo se pueda poner un punto

                                ///para que el teclado sea numerico

                                controller:preciotxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Precio",
                                    hintStyle: TextStyle(color: Colors.white,
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
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),
                                ], //para que no se puedan poner puntos o comas
                                controller:stocktxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Stock",
                                    hintStyle: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ), //para separar rows

                      Row(
                        //fila con un container y un TextField para contraseña
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),
                                ], //para que no se puedan poner puntos o comas
                                controller:telfproveedortxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Teléfono del proveedor",
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
                            onPressed: ()async {
                              if (marcatxt.text.isEmpty ||
                                  piezatxt.text.isEmpty ||
                                  preciotxt.text.isEmpty ||
                                  stocktxt.text.isEmpty ||
                                  telfproveedortxt.text.isEmpty) {
                                String error ='Rellene todos los campos antes de guardar';
                                DialogError dialogError = DialogError();
                                await dialogError.dialogError(context, error);
                              } else {
                                String marca = marcatxt.text;
                                String pieza = piezatxt.text.toLowerCase(); //lo pongo en minuscula siempre para q al buscar por este campo se busque en minuscula
                                String precio = preciotxt.text;
                                int stock = int.parse(stocktxt.text);
                                int telfproveedor =int.parse(telfproveedortxt.text);

                                //creacion id
                                //var uuid = Uuid();
                                //uuid.v1();//id basado en el tiempo
                                String id=marca+'-'+pieza;//genero un id con marca y pieza

                                var spare = Spare(
                                  id: id.toUpperCase(),
                                  marca: marca,
                                  pieza: pieza,
                                  precio: precio,
                                  stock: stock,
                                  telfproveedor: telfproveedor,
                                );
//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

                                await dt.insertSpare(context, spare);

                                marcatxt.clear();
                                piezatxt.clear();
                                preciotxt.clear();
                                stocktxt.clear();
                                telfproveedortxt.clear();

                                Navigator.of(context).pop();
                              }
                            }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                            child: Text('Guardar',style: TextStyle(fontSize: size.height / 35,color: Colors.white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ));*/

 /* Future dialogSpareUpdate(
          BuildContext context,
          Size size,
          String marca,
          String pieza,
          TextEditingController preciocontroll,
          TextEditingController stockcontroll,
          TextEditingController telfproveedorcontroll,
          String id
          ) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Actualizar Recambio',
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
                            //fila con un container y un TextField para email
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
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),], //para que solo se pueda poner un punto


                                    controller:
                                        preciocontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Precio",
                                        hintStyle: TextStyle(color: Colors.white,
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
                            children: [
                              Container(
                                width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),
                                    ],
                                    controller:stockcontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Stock",
                                        hintStyle:TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all( Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),
                                    ],
                                    controller:telfproveedorcontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Teléfono del proveedor",
                                        hintStyle:TextStyle(color: Colors.white))),
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
                                onPressed: () async{
                                  if (/*marcacontroll.text.isEmpty ||
                                      piezacontroll.text.isEmpty ||*/
                                      preciocontroll.text.isEmpty ||
                                      stockcontroll.text.isEmpty ||
                                      telfproveedorcontroll.text.isEmpty) {
                                    String error ='Rellene todos los campos antes de guardar';
                                    DialogError dialogError = DialogError();
                                    await dialogError.dialogError(context, error);
                                  } else {
                                    //String marca = marcacontroll.text;
                                    //String pieza =piezacontroll.text;
                                    String precio =preciocontroll.text;
                                    int stock = int.parse(stockcontroll.text);
                                    int telfproveedor =int.parse(telfproveedorcontroll.text);

                                    //String id=marca+'-'+pieza;

                                    var spare = Spare(
                                      id: id,
                                      marca: marca,
                                      pieza: pieza,
                                      precio: precio,
                                      stock: stock,
                                      telfproveedor: telfproveedor, 
                                    );

//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

                                    await dt.updateSpare(context,spare,id);

                                    
                                    preciocontroll.clear();
                                    stockcontroll.clear();
                                    telfproveedorcontroll.clear();

                                    Navigator.of(context).pop();
                                  }
                                }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                child: Text('Guardar',style: TextStyle(fontSize: size.height / 35,color: Colors.white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ));*/

  Future dialogSpareDelete(BuildContext context, String id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Recambio', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este recambio?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: ()async  {
                  await dt.deleteSpare(context,id);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
