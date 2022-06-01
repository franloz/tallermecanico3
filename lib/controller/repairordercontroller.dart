import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tallermecanico/alertdialog/dialogError.dart';

import '../databases/database.dart';
import '../model/repairorder.dart';

class RepairOrderController {
  Future<void> insertOrder(BuildContext context, RepairOrder order) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.insert("OrdenesReparacion", order.toMap());//inserta orden
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteOrder(BuildContext context, String id) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM LineasReparacion WHERE idorden = ?', [id]);//obtiene las lineas que pertenecen a esta orden
    int count = maps.length;//saca el numero de lineas

    if (count == 0) {//si la cantidad de lineas es 0 se puede borrar la orden sino no deja borrarla
      await database.delete("OrdenesReparacion", where: 'id = ?', whereArgs: [id]);
    } else {
      String error ='Esta orden no se puede borrar debido a que existen líneas de órdenes con esta orden, deberá borrarlas antes de poder borrar el esta orden';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> updateOrder( BuildContext context, RepairOrder order, String id) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.update("OrdenesReparacion", order.toMap(), where: 'id = ?', whereArgs: [id]);//actualiza orden
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<List<RepairOrder>> getOrders() async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.query('OrdenesReparacion');

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de clientes
      return RepairOrder(
        id: maps[i]['id'],
        vehiculo: maps[i]['vehiculo'],
        mecanico: maps[i]['mecanico'],
        horasreparacion: maps[i]['horasreparacion'],
        preciohora: maps[i]['preciohora'],
        descripcionreparacion: maps[i]['descripcionreparacion'],
        inicio: maps[i]['inicio'],
        fin: maps[i]['fin'],
        facturada: maps[i]['facturada'],
      );
    });
  }

  Future<List<RepairOrder>> getOrderWhere(String vehiculo) async {//select sobre ordenes buscando por vehiculos
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery( 'SELECT * FROM OrdenesReparacion WHERE vehiculo LIKE ?', [vehiculo + '%']);

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de clientes
      return RepairOrder(
        id: maps[i]['id'],
        vehiculo: maps[i]['vehiculo'],
        mecanico: maps[i]['mecanico'],
        horasreparacion: maps[i]['horasreparacion'],
        preciohora: maps[i]['preciohora'],
        descripcionreparacion: maps[i]['descripcionreparacion'],
        inicio: maps[i]['inicio'],
        fin: maps[i]['fin'],
        facturada: maps[i]['facturada'],
      );
    });
  }

  Future<List<Map<String, dynamic>>> getVehiclesmatricula() async {//se sacan los datos para el combobox
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT matricula FROM Vehiculos');
    return maps;
   
  }

  Future<List<Map<String, dynamic>>> getMechanicdni() async {//se sacan los datos para el combobox
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT dni FROM Mecanicos');
    return maps;
    
  }
}
