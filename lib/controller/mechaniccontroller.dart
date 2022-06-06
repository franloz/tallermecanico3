import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databases/database.dart';

import '../model/mechanic.dart';

class MechanicController {
  Future<void> insertMechanic(BuildContext context, Mechanic mechanic) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();//instancia base datos

    try {
      await database.insert("Mecanicos", mechanic.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteMechanic(BuildContext context, String dni) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    //esto es para saber si el mecanico que se quiere borrar tiene ordenes de reparacion, si las tiene no le dejará borrar al mecanico hasta que borre las ordenes
    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM OrdenesReparacion WHERE mecanico = ?', [dni]);
    int count = maps.length;

    if (count == 0) {
      await database.delete("Mecanicos", where: 'dni = ?', whereArgs: [dni]);
    } else {
      String error = 'Este mecánico no se puede borrar debido a que existen órdenes de reparación con este mecánico, deberá borrarlas antes de poder borrar al mecánico';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> updateMechanic( BuildContext context, Mechanic mechanic, String dni) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.update("Mecanicos", mechanic.toMap(), where: 'dni = ?', whereArgs: [dni]);
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<List<Mechanic>> getMechanics() async {//select sobre mecanicos
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.query('Mecanicos');

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de mecanicos
      return Mechanic(
        dni: maps[i]['dni'],
        nombre: maps[i]['nombre'],
        telf: maps[i]['telf'],
        direccion: maps[i]['direccion'],
      );
    });
  }

  Future<List<Mechanic>> getMechanicWhere(String nombre) async {//select sobre mecanicos para la busqueda
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT * FROM Mecanicos WHERE nombre LIKE ?', [nombre + '%']);

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de Mecanicos
      return Mechanic(
        dni: maps[i]['dni'],
        nombre: maps[i]['nombre'],
        telf: maps[i]['telf'],
        direccion: maps[i]['direccion'],
      );
    });
  }
}
