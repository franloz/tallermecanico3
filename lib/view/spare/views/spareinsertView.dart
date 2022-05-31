import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/spare.dart';

import '../../../controller/sparecontroller.dart';

class SpareInsertView extends StatefulWidget {
  const SpareInsertView({Key? key}) : super(key: key);

  @override
  State<SpareInsertView> createState() => _ScreenState();
}

class _ScreenState extends State<SpareInsertView> {
  TextEditingController marcatxt = TextEditingController();
  TextEditingController piezatxt = TextEditingController();
  TextEditingController preciotxt =TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController stocktxt = TextEditingController();
  TextEditingController telfproveedortxt = TextEditingController();

  //DatabaseSqlite dt = DatabaseSqlite();
  SpareController cr=SpareController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Añadir recambio'),
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
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller: marcatxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Marca",
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
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller: piezatxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,///para que el teclado sea numerico
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]+[.]{0,1}[0-9]*')),], //para que solo se pueda poner un punto
                      controller: preciotxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Precio",
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
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]{0,1}[0-9]*')),], //para que no se puedan poner puntos o comas
                      controller: stocktxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
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
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]{0,1}[0-9]*')),], //para que no se puedan poner puntos o comas
                      controller:telfproveedortxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  onPressed: () async {
                    if (marcatxt.text.isEmpty ||
                        piezatxt.text.isEmpty ||
                        preciotxt.text.isEmpty ||
                        stocktxt.text.isEmpty ||
                        telfproveedortxt.text.isEmpty) {
                      String error =
                          'Rellene todos los campos antes de guardar';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {
                      String marca = marcatxt.text;
                      String pieza = piezatxt.text.toLowerCase(); //lo pongo en minuscula siempre para q al buscar por este campo se busque en minuscula
                      String precio = preciotxt.text;
                      int stock = int.parse(stocktxt.text);
                      int telfproveedor = int.parse(telfproveedortxt.text);

                      //creacion id
                     
                      String id = marca + '-' + pieza; //genero un id con marca y pieza

                      var spare = Spare(
                        id: id.toUpperCase(),
                        marca: marca,
                        pieza: pieza,
                        precio: precio,
                        stock: stock,
                        telfproveedor: telfproveedor,
                      );

                      await cr.insertSpare(context, spare);

                      marcatxt.clear();
                      piezatxt.clear();
                      preciotxt.clear();
                      stocktxt.clear();
                      telfproveedortxt.clear();

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
