import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/Vehicle.dart';

import '../model/client.dart';
import '../model/mechanic.dart';

class DatabaseSqlite {
  Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_db.db'),
      version: 7,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE Clientes (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
        );
      },
      onUpgrade: (db, int oldversion, int newversion) {
        if (oldversion != newversion) {
          print('gfgg');
          /*return db.execute(
            "CREATE TABLE Mecanicos (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
          );*/
          return db.execute(
            "CREATE TABLE Vehiculos (matricula TEXT PRIMARY KEY, marca TEXT NOT NULL, modelo TEXT NOT NULL, clientedni TEXT NOT NULL,FOREIGN KEY (clientedni) REFERENCES Clientes (dni))",
          );
        }
      },
    );
  }

  //cliente
  Future<void> insertClient(BuildContext context, Client client) async {
    Database database = await _openDB();

    try {
      await database.insert("Clientes", client.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteClient(String dni) async {
    Database database = await _openDB();

    await database.delete("Clientes", where: 'dni = ?', whereArgs: [dni]);
  }

  Future<void> updateClient(
      BuildContext context, Client client, String dni) async {
    Database database = await _openDB();

    try {
      await database.update("Clientes", client.toMap(),
          where: 'dni = ?', whereArgs: [dni]);
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<List<Client>> getClients() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps = await database.query('Clientes');

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

  Future<List<Client>> getClientsWhere(String nombre) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps = await database
        .rawQuery('SELECT * FROM Clientes WHERE nombre LIKE ?', [nombre + '%']);

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

  //cliente

  //mecanico

  Future<void> insertMechanic(BuildContext context, Mechanic mechanic) async {
    Database database = await _openDB();

    try {
      await database.insert("Mecanicos", mechanic.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteMechanic(String dni) async {
    Database database = await _openDB();

    await database.delete("Mecanicos", where: 'dni = ?', whereArgs: [dni]);
  }

  Future<void> updateMechanic(
      BuildContext context, Mechanic mechanic, String dni) async {
    Database database = await _openDB();

    try {
      await database.update("Mecanicos", mechanic.toMap(),
          where: 'dni = ?', whereArgs: [dni]);
    } on DatabaseException catch (e) {
      String error = 'Este dni ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<List<Mechanic>> getMechanics() async {
    Database database = await _openDB();

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

  Future<List<Mechanic>> getMechanicWhere(String nombre) async {
    Database database = await _openDB();

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

  //mecanico

  //vehículos

  Future<void> insertVehicle(BuildContext context, Vehicle vehicle) async {
    Database database = await _openDB();

    try {
      await database.insert("Vehiculos", vehicle.toMap());
    } on DatabaseException catch (e) {
      String error =
          'Esta matricula ya existe, no puede volverla a introducir, o cliente no existe';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteVehicle(String matricula) async {
    Database database = await _openDB();

    await database
        .delete("Vehiculos", where: 'matricula = ?', whereArgs: [matricula]);
  }

  Future<void> updateVehicle(
      BuildContext context, Vehicle vehicle, String matricula) async {
    Database database = await _openDB();

    try {
      await database.update("Vehiculos", vehicle.toMap(),
          where: 'matricula = ?', whereArgs: [matricula]);
    } on DatabaseException catch (e) {
      String error = 'Esta matricula ya existe, no puede volverla a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<List<Vehicle>> getVehicles() async {
    Database database = await _openDB();

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

  Future<List<Vehicle>> getVehicleWhere(String nombre) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT * FROM Vehiculos WHERE nombre LIKE ?', [nombre + '%']);

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

  //vehículos
}
