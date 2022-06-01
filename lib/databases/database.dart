import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';


class DatabaseSqlite {
  Future<Database> openDB() async {//se crea la base de datos de sqlite
    return openDatabase(
      join(await getDatabasesPath(), 'my_db.db'),
      version: 3,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Clientes (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
        );
        await db.execute(
          "CREATE TABLE Mecanicos (dni TEXT PRIMARY KEY, nombre TEXT NOT NULL, telf INTEGER NOT NULL, direccion TEXT)",
        );
        await db.execute(
          "CREATE TABLE Vehiculos (matricula TEXT PRIMARY KEY, marca TEXT NOT NULL, modelo TEXT NOT NULL, clientedni TEXT NOT NULL,FOREIGN KEY (clientedni) REFERENCES Clientes (dni))",
        );
        await db.execute(
          "CREATE TABLE Recambios (id TEXT PRIMARY KEY, marca TEXT NOT NULL, pieza TEXT NOT NULL, precio TEXT NOT NULL,stock INTEGER NOT NULL, telfproveedor INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE OrdenesReparacion (id TEXT PRIMARY KEY, vehiculo TEXT NOT NULL, mecanico TEXT NOT NULL, horasreparacion TEXT,preciohora TEXT,descripcionreparacion TEXT, inicio TEXT NOT NULL,fin TEXT,facturada INTEGER NOT NULL,FOREIGN KEY (vehiculo) REFERENCES Vehiculos (matricula),FOREIGN KEY (mecanico) REFERENCES Mecanicos (dni))",
        );
        await db.execute(
          "CREATE TABLE LineasReparacion (idorden TEXTNOT NULL, idlinea TEXT NOT NULL, idrecambio TEXT NOT NULL, cantidad INTEGER NOT NULL,PRIMARY KEY (idorden, idlinea),FOREIGN KEY (idorden) REFERENCES OrdenesReparacion (id),FOREIGN KEY (idrecambio) REFERENCES Recambios (id))",
        );
      },
      onUpgrade: (db, int oldversion, int newversion) {
        if (oldversion != newversion) {
          
          
        }
      },
    );
  }

 

}
