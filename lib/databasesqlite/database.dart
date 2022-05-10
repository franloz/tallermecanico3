import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:tallermecanico/utils/utils.dart';

import '../model/client.dart';

class DatabaseSqlite {
  Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'my_db.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE Clientes (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
      );
    }, version: 1);
  }

  Future<void> insertClient(Client client) async {
    Database database = await _openDB();

    try {
      var d = await database.insert("Clientes", client.toMap());
      print('jjj' + d.toString());
      //return v;
    } on DatabaseException catch (e) {
      print('jjffdfdfj');
      //Utils u = Utils();
      //u.dialogErrorInsert(context, error)
      //////////////////////////lanzar aqui dialog
      //int b = 9;
      //return b;
    }
  }

  Future<void> deleteClient(String dni) async {
    Database database = await _openDB();

    await database.delete("Clientes", where: 'dni = ?', whereArgs: [dni]);
  }

  Future<void> updateClient(Client client) async {
    Database database = await _openDB();

    await database.update("Clientes", client.toMap(),
        where: 'dni = ?', whereArgs: [client.dni]);
  }

  /* Future<List<Client>> getClients() async {
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
  }*/

  Future<List<Client>> getClients() async {
    Database database = await _openDB();

    var clients = await database.query('Clientes');
    List<Client> clientsList = clients.isNotEmpty
        ? clients.map((c) => Client.fromMap(c)).toList()
        : [];

    return clientsList;
  }

/*
  
  Database database;

  initDB() async {
    //metodo que inicializa la base de datos de forma sincrona
    database = await openDatabase('my_db.db', //archivo de la base de datos
        version: 1, onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE Clientes (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT) ");
    });
    print('database correcta');
  }

  insert(Client client) async {
    //metodo para insertar clientes
    database.insert("Clientes", client.toMap());
  }

  /*Future<List<Client>> getAllClients() async{//metodo para extraer datos 
    List<Map<String,dynamic>> result=await database.query("Clientes");//es un select * from Clientes, devolvera un mapa de datos con sus campos y valores
    return result.map((map) => Client.fromMap(map));//se convierte la lista de mapas a una lista de clientes


  }*/

  Future<List<Client>> getClients() async {
    // Query the table for all The Clientes.
    List<Map<String, dynamic>> maps = await database.query("Clientes");

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Client(
        dni: maps[i]['dni'],
        nombre: maps[i]['nombre'],
        telf: maps[i]['telf'],
        direccion: maps[i]['direccion'],
      );
    });
  }*/
}
