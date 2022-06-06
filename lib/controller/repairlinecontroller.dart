import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databases/database.dart';

import '../model/repairLines.dart';

class RepairLineController {
  Future<void> insertLines(BuildContext context, RepairLines lines, String idrecambio, int cantidad) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      var resultSet = await database.rawQuery("SELECT stock FROM Recambios WHERE id = ?", [idrecambio]);//obtengo el stock del recambio que ha elegido
      // Get first result
      var dbItem = resultSet.first;
      // Access its id
      var stock = dbItem['stock'] as int;//stock

      if (stock >= cantidad) {//si hay suficiente stock en recambios
        stock = stock - cantidad;//le resto a stock la cantidad del recambio elegida
        await database.insert("LineasReparacion", lines.toMap());
        await database.rawUpdate("UPDATE Recambios SET stock = ? WHERE id = ?", [stock, idrecambio]); //se actualiza el stock de recambios

      } else {
        String error ='No hay suficiente stock para este cantidad del recambio';
        DialogError dialogError = DialogError();
        await dialogError.dialogError(context, error);
      }
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> updateLine(BuildContext context, String idorden, String idlinea,String idrecambio, int cantidadold, int cantidadnew) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      var resultSet = await database.rawQuery("SELECT stock FROM Recambios WHERE id = ?", [idrecambio]);//obtengo el stock del recambio que ha elegido
      // Get first result
      var dbItem = resultSet.first;
      // Access its id
      var stock = dbItem['stock']as int; //saco el stock que hay ahora mismo en el recambio

      //a este stock le sumo cantidadold que es la cantidad que ahora mismo tiene la linea
      stock = stock + cantidadold;

      if (stock >= cantidadnew) {
        //compruebo si la cantidad nueva es igual o mas pequeña que el stock, si es asi actualizo el stock
        stock = stock -cantidadnew; //ahora le resto a stock cantidadnew que es la nueva cantidad introducida al actualizar

        await database.rawUpdate("UPDATE LineasReparacion SET cantidad = ? WHERE idorden = ? and idlinea = ?",[cantidadnew,idorden,idlinea]); //actualizo la linea con la nueva cantidad

        await database.rawUpdate("UPDATE Recambios SET stock = ? WHERE id = ?",[stock, idrecambio]); //se actualiza el stock de recambios

      } else {
        String error ='No hay suficiente stock para este cantidad del recambio';
        DialogError dialogError = DialogError();
        await dialogError.dialogError(context, error);
      }

    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteLines(String idorden, String idlinea, String idrecambio, int cantidad) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    var resultSet = await database.rawQuery("SELECT stock FROM Recambios WHERE id = ?", [idrecambio]); //saco el stock actual del recambio
    // Get first result
    var dbItem = resultSet.first;
    // Access its id
    var stock = dbItem['stock'] as int;

    stock = stock + cantidad; //nuevo stock despues de borrar. Al stock actual le sumo el del recambio que tenia esta linea

    await database.rawUpdate("UPDATE Recambios SET stock = ? WHERE id = ?", [stock, idrecambio]); //se actualiza el stock de reacmbios

    await database.rawDelete( "DELETE FROM  LineasReparacion WHERE idorden= ? AND idlinea = ?", [idorden, idlinea]);
  }

  Future<List<RepairLines>> getLines(String idorden) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery( "SELECT * FROM LineasReparacion WHERE idorden = ?", [idorden]);

    return List.generate(maps.length, (i) {
      return RepairLines(
        idorden: maps[i]['idorden'],
        idlinea: maps[i]['idlinea'],
        idrecambio: maps[i]['idrecambio'],
        cantidad: maps[i]['cantidad'],
      );
    });
  }

  Future<List<RepairLines>> getLinesWhere(
      String recambio, String idorden) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery( 'SELECT * FROM LineasReparacion WHERE idorden = ? and idrecambio LIKE ?', [idorden, recambio + '%']);

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de clientes
      return RepairLines(
        idorden: maps[i]['idorden'],
        idlinea: maps[i]['idlinea'],
        idrecambio: maps[i]['idrecambio'],
        cantidad: maps[i]['cantidad'],
      );
    });
  }

  Future<List<Map<String, dynamic>>> getRecambiosId() async {//obtengo los dni de los clientes para el combobox
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT id FROM Recambios');
    return maps;
    
  }

}
