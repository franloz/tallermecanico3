import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databases/database.dart';

import '../model/vehicle.dart';

class VehicleController {
  Future<void> insertVehicle(BuildContext context, Vehicle vehicle) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.insert("Vehiculos", vehicle.toMap());
    } on DatabaseException catch (e) {
      String error = 'Esta matricula ya existe, no puede volverla a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteVehicle(BuildContext context, String matricula) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();
    final List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT * FROM OrdenesReparacion WHERE vehiculo = ?', [matricula]);
    int count = maps.length;

    if (count == 0) {
      await database
          .delete("Vehiculos", where: 'matricula = ?', whereArgs: [matricula]);
      print('bbbbb' + 'borrado');
    } else {
      String error =
          'Este vehículo no se puede borrar debido a que existen órdenes de reparación con este vehículo, deberá borrarlas antes de poder borrar el vehículo';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> updateVehicle(
      BuildContext context, Vehicle vehicle, String matricula) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.update("Vehiculos", vehicle.toMap(),
          where: 'matricula = ?', whereArgs: [matricula]);
    } on DatabaseException catch (e) {
      String error = 'Esta matricula ya existe, no puede volverla a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<List<Vehicle>> getVehicles() async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.query('Vehiculos');

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de vehiculos
      return Vehicle(
        matricula: maps[i]['matricula'],
        marca: maps[i]['marca'],
        modelo: maps[i]['modelo'],
        clientedni: maps[i]['clientedni'],
      );
    });
  }

  Future<List<Vehicle>> getVehicleWhere(String matricula) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT * FROM Vehiculos WHERE matricula LIKE ?', [matricula + '%']);

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de Mecanicos
      return Vehicle(
        matricula: maps[i]['matricula'],
        marca: maps[i]['marca'],
        modelo: maps[i]['modelo'],
        clientedni: maps[i]['clientedni'],
      );
    });
  }

  Future<List<Map<String, dynamic>>> getClientsdni() async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT dni FROM Clientes');
    return maps;
    /*forEach(maps){
      String dni=maps;
    }*/
  }
}
