import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/clientController.dart';

class DialogClientsDelete {
  //DatabaseSqlite dt = DatabaseSqlite();
  ClientController cr=ClientController();

  Future dialogClientDelete(BuildContext context, String dni) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Cliente', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este cliente?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await cr.deleteClient(context, dni); //metodo que borra en la base de datos
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
