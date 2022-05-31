import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../alertdialog/dialogError.dart';
import '../databases/database.dart';
import '../model/bill.dart';

class BillController {
  final user = FirebaseAuth.instance.currentUser!;

  Future insertBill(BuildContext context, String idorden, double descuento,
      double iva) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    var resultSet = await database.rawQuery(
        "SELECT preciohora FROM OrdenesReparacion WHERE id = ?",
        [idorden]); //obtenemos el preciohora de la orden
    var dbpreciohora = resultSet.first;

    var resultSet2 = await database.rawQuery(
        "SELECT horasreparacion FROM OrdenesReparacion WHERE id = ?",
        [idorden]); //obtenemos el horasreparacion de la orden
    var dbhorasreparacion = resultSet2.first;

    String preciohorastring = dbpreciohora['preciohora']
        as String; //se coge el preciohora de esta orden
    print('preco' + preciohorastring);

    String horasreparaciontring = dbhorasreparacion['horasreparacion']
        as String; //se coge horas de reparacion de esta orden
    print('repa' + horasreparaciontring);

    /////////estos campos solo los saco para comprobar si están vacios, si lo estan le dice al usuario que debe rellenar todos los campos de la orden antes de facturarla
    var resultSet3 = await database.rawQuery(
        "SELECT descripcionreparacion FROM OrdenesReparacion WHERE id = ?",
        [idorden]);
    var dbdescripcionreparacion = resultSet3.first;

    var resultSet4 = await database
        .rawQuery("SELECT fin FROM OrdenesReparacion WHERE id = ?", [idorden]);
    var dbfin = resultSet4.first;

    String descripcionreparacionstring =
        dbdescripcionreparacion['descripcionreparacion'] as String;
    String fintring = dbfin['fin'] as String;
    ///////////

    if (preciohorastring == '' ||
        horasreparaciontring == '' ||
        descripcionreparacionstring == '' ||
        fintring == 'Fin') {
      String error =
          'Debes completar todos los campos de la orden para poder facturarla';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    } else {
      double preciohora = double.parse(preciohorastring);

      double horasreparacion = double.parse(horasreparaciontring);

      //se multiplican las horas de reparacion por el precio de la hora
      double total = horasreparacion * preciohora;
      print('total' + total.toString());

      List<Map<String, dynamic>> maps = await database.rawQuery(
          "SELECT idrecambio,cantidad  FROM LineasReparacion WHERE idorden = ?",
          [idorden]); //se obtiene la lista de recambios de lineas
      // Get first result
      print('1');

      for (var element in maps) {
        //se recorre la lista de lineas y por cada recambio se saca su precio y se multiplica por la cantidad

        String idrecambio = element[
            'idrecambio']; //se obtiene el id del recambio y la cantidad de cada linea

        int cantidad = element['cantidad'];

        var resultSet = await database.rawQuery(
            "SELECT precio FROM Recambios WHERE id = ?",
            [idrecambio]); //se obtiene el precio del recambio
        var dbItem = resultSet.first;
        String preciostring =
            dbItem['precio'] as String; //se coge el precio de esta orden

        double precio = double.parse(preciostring);

        total = total +
            (cantidad *
                precio); //al total se le van sumando el resultado de la multiplicaion de cantidad * precio de todos los recambios usados en las lineas

        print(total);
      }

      print('2');

      String baseimponible = total.toStringAsFixed(2); //se redondea el total
      print('uuu' + baseimponible);

      try {
        //cantidad descuento    //cantidad iva
        double totalfactura =
            total - (total * (descuento / 100)) + (total * (iva / 100));

        String totalfactstring =
            totalfactura.toStringAsFixed(2); //se redondea el total
        final docBill = FirebaseFirestore.instance.collection('facturas').doc();
        var bill = Bill(
          id: docBill.id,
          userid: user.uid,
          idorden: idorden,
          baseimponible: baseimponible,
          descuento: descuento.toString(),
          iva: iva.toString(),
          totalfactura: totalfactstring,
        );

        // spare.id = docSpare.id; //le asigno el id que genere firebase

        final json = bill.toJson();
        await docBill.set(json);
        print('insertadoooooooooooo');

        //actualizar ordenes

        await database.rawUpdate(
            "UPDATE OrdenesReparacion SET facturada = ? WHERE id = ?", [
          1,
          idorden
        ]); //actualiza el campo facturada de la orden y lo pongo a 1 que indica que la orden ha sido facturada

      } on FirebaseException catch (e) {
        String error = 'Error al insertar';
        DialogError dialogError = DialogError();
        dialogError.dialogError(context, error);
      }
    }
  }

  Future deleteBill(String id, String idorden) async {
    final docbill = FirebaseFirestore.instance.collection('facturas').doc(id);

    docbill.delete();

    //actualizo la orden de la factura y la pongo en no facturada
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();
    await database.rawUpdate(
        "UPDATE OrdenesReparacion SET facturada = ? WHERE id = ?",
        [0, idorden]);
  }





  Future<List<Map<String, dynamic>>> getOrdenesId() async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT id FROM OrdenesReparacion');
    return maps;
    /*forEach(maps){
      String dni=maps;
    }*/
  }
}
