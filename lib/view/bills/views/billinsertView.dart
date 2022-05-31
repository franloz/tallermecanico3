import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databases/database.dart';

import '../../../controller/billcontroller.dart';

class BillInsertView extends StatefulWidget {
  const BillInsertView({Key? key}) : super(key: key);

  @override
  State<BillInsertView> createState() => _ScreenState();
}

class _ScreenState extends State<BillInsertView> {
  TextEditingController descuentotxt = TextEditingController();
  TextEditingController ivatxt = TextEditingController();

  //FirebaseDatabase base = FirebaseDatabase();
  BillController cr=BillController();

  String? orden; //values combobox

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map? parametros = ModalRoute.of(context)?.settings.arguments as Map?; //para coger el argumento q se pasa desde la otra pantalla
    List<String> listaordenes = parametros!["listaordenes"];

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Añadir cliente'),
        ),
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              //fila con un container y un TextField para contraseña
              mainAxisAlignment:MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all( Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,//teclado numerico
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')), ],//que solo permita un punto
                      controller:descuentotxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Descuento",
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),

            Row(
              //fila con un container y un TextField para contraseña
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(  Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]+[.]{0,1}[0-9]*')),],
                      controller: ivatxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Iva",
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),
            Row(
              //fila con un container y un TextField para contraseña
              mainAxisAlignment:  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                    width: size.width / 1.1,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Elige orden',style: TextStyle(color: Colors.white)),
                      value: orden,
                      items: listaordenes
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => orden = item),
                    ))
                //se convierte la lista de String a DropdownMenuItem<String>
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
                    DatabaseSqlite dt = DatabaseSqlite();

                    if (orden == null) {//si no elige orden en el combobox salta error
                      String error = 'Debe elegir orden';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {//si elige comprueba que no este facturada mediante consulta en base datos
                      Database database = await dt.openDB();
                      var resultSet = await database.rawQuery("SELECT facturada FROM OrdenesReparacion WHERE id = ?",[orden.toString()]);
                      // Get first result
                      var dbItem = resultSet.first;
                      // Access its id
                      var facturada = dbItem['facturada'] as int;
                      print('fac' + facturada.toString());

                      if (facturada == 0) {
                        //si facturada es igual a 0 significa q no esta facturada , si no es igual a 0 está ya facturada

                        String idorden = orden.toString();
                        double descuento;
                        double iva;

                        if (descuentotxt.text.isEmpty) {//si el campo de descuento esta vacio le aplica descuento 0
                          descuento = 0;
                        } else {
                          descuento = double.parse(descuentotxt.text);
                        }

                        if (ivatxt.text.isEmpty) {
                          iva = 0;
                        } else {
                          iva = double.parse(ivatxt.text);
                        }

                        cr.insertBill(context, idorden, descuento, iva);//metodo que inserta en la base de datos
                      } else {
                        String error = 'Esta orden ya ha sido facturada';
                        DialogError dialogError = DialogError();
                        await dialogError.dialogError(context, error);
                      }
                    }

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
