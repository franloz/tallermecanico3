import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/Vehicle.dart';
import 'package:tallermecanico/model/repairLines.dart';
import 'package:tallermecanico/model/repairorder.dart';
import 'package:tallermecanico/model/spare.dart';

import '../model/client.dart';
import '../model/mechanic.dart';

class DatabaseSqlite {
  Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_db.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Clientes (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
        );
        await db.execute(
          "CREATE TABLE Mecanicos (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
        );
        await db.execute(
          "CREATE TABLE Vehiculos (matricula TEXT PRIMARY KEY, marca TEXT NOT NULL, modelo TEXT NOT NULL, clientedni TEXT NOT NULL,FOREIGN KEY (clientedni) REFERENCES Clientes (dni))",
        ); ////////////poner las otras tablas, pensar la repeticion de datos para hacerlo en firebase
        await db.execute(
          "CREATE TABLE Recambios (id TEXT PRIMARY KEY, marca TEXT NOT NULL, pieza TEXT NOT NULL, precio TEXT NOT NULL,stock INTEGER NOT NULL, telfproveedor INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE OrdenesReparacion (id TEXT PRIMARY KEY, vehiculo TEXT NOT NULL, mecanico TEXT NOT NULL, horasreparacion TEXT,preciohora TEXT,descripcionreparacion TEXT, inicio TEXT NOT NULL,fin TEXT,FOREIGN KEY (vehiculo) REFERENCES Vehiculos (matricula),FOREIGN KEY (mecanico) REFERENCES Mecanicos (dni))",
        );//añadirle un apartado de facturada, si es true q no le deje generar mas facturas
        await db.execute(
          "CREATE TABLE LineasReparacion (idorden TEXTNOT NULL, idlinea TEXT NOT NULL, idrecambio TEXT NOT NULL, cantidad INTEGER NOT NULL,PRIMARY KEY (idorden, idlinea),FOREIGN KEY (idorden) REFERENCES OrdenesReparacion (id),FOREIGN KEY (idrecambio) REFERENCES Recambios (id))",
        );
      },
      onUpgrade: (db, int oldversion, int newversion) {
        if (oldversion != newversion) {
          print('gfgg');
          /*return db.execute(
            "CREATE TABLE Mecanicos (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
          );*/
          /*return db.execute(
            "CREATE TABLE Vehiculos (matricula TEXT PRIMARY KEY, marca TEXT NOT NULL, modelo TEXT NOT NULL, clientedni TEXT NOT NULL,FOREIGN KEY (clientedni) REFERENCES Clientes (dni))",
          );*/
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

  Future<void> deleteClient(BuildContext context,String dni) async {
    Database database = await _openDB();

    //esto es para saber si el cliente que se quiere borrar tiene vehiculos, si las tiene no le dejará borrar al cliente hasta que borre las vehiculos
    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM Vehiculos WHERE clientedni = ?', [dni]);
    int count=   maps.length;//si dejase borrar a los clientes y luego pulsase sobre modificar en un vehiculo que contenia a ese cliente daria error el combobox porque ese cliente ya no existe
    print('jjjj'+count.toString());

    if(count==0){
      await database.delete("Clientes", where: 'dni = ?', whereArgs: [dni]);
      print('bbbbb'+'borrado');
    }else{
      String error = 'Este cliente no se puede borrar debido a que existen vehículos con este cliente, deberá borrarlos antes de poder borrar al cliente';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }

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

  Future<void> deleteMechanic(BuildContext context,String dni) async {
    Database database = await _openDB();


    //esto es para saber si el mecanico que se quiere borrar tiene ordenes de reparacion, si las tiene no le dejará borrar al mecanico hasta que borre las ordenes
    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM OrdenesReparacion WHERE mecanico = ?', [dni]);
    int count=   maps.length;
    print('jjjj'+count.toString());

    if(count==0){
      await database.delete("Mecanicos", where: 'dni = ?', whereArgs: [dni]);
      print('bbbbb'+'borrado');
    }else{
      String error = 'Este mecánico no se puede borrar debido a que existen órdenes de reparación con este mecánico, deberá borrarlas antes de poder borrar al mecánico';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }

    
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
      String error = 'Esta matricula ya existe, no puede volverla a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteVehicle(BuildContext context,String matricula) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM OrdenesReparacion WHERE vehiculo = ?', [matricula]);
    int count=   maps.length;
    print('jjjj'+count.toString());

    if(count==0){
      await database.delete("Vehiculos", where: 'matricula = ?', whereArgs: [matricula]);
      print('bbbbb'+'borrado');
    }else{
      String error = 'Este vehículo no se puede borrar debido a que existen órdenes de reparación con este vehículo, deberá borrarlas antes de poder borrar el vehículo';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }

    
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

  Future<List<Vehicle>> getVehicleWhere(String matricula) async {
    Database database = await _openDB();

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

  //vehículos


  //combobox

   Future<List<Map<String, dynamic>>> getClientsdni() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT dni FROM Clientes');
    return maps;
    /*forEach(maps){
      String dni=maps;
    }*/
  }


  Future<List<Map<String, dynamic>>> getVehiclesmatricula() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT matricula FROM Vehiculos');
    return maps;
    /*forEach(maps){
      String dni=maps;
    }*/
  }

  Future<List<Map<String, dynamic>>> getMechanicdni() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT dni FROM Mecanicos');
    return maps;
    /*forEach(maps){
      String dni=maps;
    }*/
  }

  Future<List<Map<String, dynamic>>> getRecambiosId() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT id FROM Recambios');
    return maps;
    /*forEach(maps){
      String dni=maps;
    }*/
  }



  //combobox



  //spare

  Future<void> insertSpare(BuildContext context, Spare spare) async {
    Database database = await _openDB();

    try {
      await database.insert("Recambios", spare.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este recambio (id) ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteSpare(BuildContext context,String id) async {
    Database database = await _openDB();


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
    Database database = await _openDB();

    try {
      await database.update("Recambios", spare.toMap(),
          where: 'id = ?', whereArgs: [id]);
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }
  Future<List<Spare>> getSpares() async {
    Database database = await _openDB();

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
    Database database = await _openDB();

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


  //spare

  //repairorder

  Future<void> insertOrder(BuildContext context, RepairOrder order) async {
    Database database = await _openDB();

    try {
      await database.insert("OrdenesReparacion", order.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }

  Future<void> deleteOrder(BuildContext context, String id) async {
    Database database = await _openDB();


    final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM LineasReparacion WHERE idorden = ?', [id]);
    int count=   maps.length;
    print('jjjj'+count.toString());

    if(count==0){
      await database.delete("OrdenesReparacion", where: 'id = ?', whereArgs: [id]);
      print('bbbbb'+'borrado');
    }else{
      String error = 'Esta orden no se puede borrar debido a que existen líneas de órdenes con esta orden, deberá borrarlas antes de poder borrar el esta orden';
      DialogError dialogError = DialogError();
      await dialogError.dialogError(context, error);
    }
    
  }

  Future<void> updateOrder(BuildContext context, RepairOrder order, String id) async {
    Database database = await _openDB();

    try {
      await database.update("OrdenesReparacion", order.toMap(),
          where: 'id = ?', whereArgs: [id]);
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }
  }
  Future<List<RepairOrder>> getOrders() async {
    Database database = await _openDB();

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
        fin:maps[i]['fin'],
      );
    });
  }

 

  Future<List<RepairOrder>> getOrderWhere(String vehiculo) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps = await database
        .rawQuery('SELECT * FROM OrdenesReparacion WHERE vehiculo LIKE ?', [vehiculo + '%']);

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
        fin:maps[i]['fin'],
      );
    });
  }


  //repairorder


  //repairlines


  Future<void> insertLines(BuildContext context, RepairLines lines) async {
    Database database = await _openDB();

    try {
      await database.insert("LineasReparacion", lines.toMap());
    } on DatabaseException catch (e) {
      String error = 'Este id ya existe, no puede volverlo a introducir';
      DialogError dialogError = DialogError();
      dialogError.dialogError(context, error);
    }

    ///////////////////quitar del stock recambios 






  }

  Future<void> deleteLines( String idorden, String idlinea, String idrecambio, int cantidad ) async {
    Database database = await _openDB();


      var resultSet = await database.rawQuery("SELECT stock FROM Recambios WHERE id = ?",[idrecambio]);
      // Get first result
      var dbItem = resultSet.first;
      // Access its id
      var stock = dbItem['stock'] as int;
      print(stock);


      stock=stock+cantidad;//nuevo stock despues de borrar

      await database.rawUpdate("UPDATE Recambios SET stock = ? WHERE id = ?",[stock,idrecambio]);//se actualiza el stock de reacmbios

      await database.rawDelete("DELETE FROM  LineasReparacion WHERE idorden= ? AND idlinea = ?", [idorden,idlinea]);

    
    
  }

  


  Future<List<RepairLines>> getLines(String idorden) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps = await database.rawQuery("SELECT * FROM LineasReparacion WHERE idorden = ?", [idorden]);

    return List.generate(maps.length, (i) {
      return RepairLines (
        idorden: maps[i]['idorden'],
        idlinea: maps[i]['idlinea'],
        idrecambio: maps[i]['idrecambio'],
        cantidad: maps[i]['cantidad'],
       
      );
    });
  }

  Future<List<RepairLines>> getLinesWhere(String recambio,String idorden) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> maps = await database
        .rawQuery('SELECT * FROM LineasReparacion WHERE idorden = ? and idrecambio LIKE ?', [idorden,recambio + '%']);

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



  //repairlines

}
