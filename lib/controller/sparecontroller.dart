import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databases/database.dart';

import '../model/spare.dart';


class SpareController {
  Future<void> insertSpare(BuildContext context, Spare spare) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.insert("Recambios", spare.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este recambio (id) ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteSpare(BuildContext context,String id) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();


    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM LineasReparacion WHERE idrecambio = ?', [id]);
    int count=   maps.length;
    print('jjjj'+count.toString());

    if(count==0){
      await database.delete("Recambios", where: 'id = ?', whereArgs: [id]);
      print('bbbbb'+'borrado');
    }else{
      String error = 'Este recambio no se puede borrar debido a que existen lineas de órdenes con este recambio, deberá borrarlas antes de poder borrar el recambio';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }

  }

  Future<void> updateSpare(BuildContext context, Spare spare, String id) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.update("Recambios", spare.toMap(),
          where: 'id = ?', whereArgs: [id]);
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }
  Future<List<Spare>> getSpares() async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.query('Recambios');

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de clientes
      return Spare(
        id: maps[i]['id'],
        marca: maps[i]['marca'],
        pieza: maps[i]['pieza'],
        precio: maps[i]['precio'],
        stock: maps[i]['stock'],
        telfproveedor: maps[i]['telfproveedor'],
      );
    });
  }

 

  Future<List<Spare>> getSpareWhere(String pieza) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database
        .rawQuery('SELECT * FROM Recambios WHERE pieza LIKE ?', [pieza + '%']);

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de clientes
      return Spare(
        id: maps[i]['id'],
        marca: maps[i]['marca'],
        pieza: maps[i]['pieza'],
        precio: maps[i]['precio'],
        stock: maps[i]['stock'],
        telfproveedor: maps[i]['telfproveedor'],
      );
    });
  }
}
