import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databases/database.dart';
import 'package:tallermecanico/model/client.dart';

class ClientController {
  
  Future<void> insertClient(BuildContext context, Client client) async {//metodo para insertar cliente
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.insert("Clientes", client.toMap());//se inserta en sqlite
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteClient(BuildContext context, String dni) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    //esto es para saber si el cliente que se quiere borrar tiene vehiculos, si los tiene no le dejará borrar al cliente hasta que borre las vehiculos
    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM Vehiculos WHERE clientedni = ?', [dni]);
    int count = maps .length; //si dejase borrar a los clientes y luego pulsase sobre modificar en un vehiculo que contenia a ese cliente daria error el combobox porque ese cliente ya no existe

    if (count == 0) {//si cliente no tiene coches asociados se borra
      await database.delete("Clientes", where: 'dni = ?', whereArgs: [dni]);
    } else {
      String error ='Este cliente no se puede borrar debido a que existen vehículos con este cliente, deberá borrarlos antes de poder borrar al cliente';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<void> updateClient(BuildContext context, Client client, String dni) async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    try {
      await database.update("Clientes", client.toMap(), where: 'dni = ?', whereArgs: [dni]);//se actualiza cliente
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
  }

  Future<List<Client>> getClients() async {
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.query('Clientes');//hace un select sobre clientes

    return List.generate(maps.length, (i) {
      //convierte la lista de maps a una lista de clientes
      return Client(
        dni: maps[i]['dni'],
        nombre: maps[i]['nombre'],
        telf: maps[i]['telf'],
        direccion: maps[i]['direccion'],
      );
    });
  }

  Future<List<Client>> getClientsWhere(String nombre) async {//este metodo es para la búsqueda
    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM Clientes WHERE nombre LIKE ?', [nombre + '%']);

    return List.generate(maps.length, (i) {
      //convierte la lista de mapas a una lista de clientes
      return Client(
        dni: maps[i]['dni'],
        nombre: maps[i]['nombre'],
        telf: maps[i]['telf'],
        direccion: maps[i]['direccion'],
      );
    });
  }


}
