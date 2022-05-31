import 'package:flutter/material.dart';
import 'package:tallermecanico/databases/database.dart';

class DialogRepairOrderDelete {
  DatabaseSqlite dt = DatabaseSqlite();

  Future dialogOrderDelete(BuildContext context, String id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title: Text('Borrar Orden', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar esta orden?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await dt.deleteOrder(context, id);

                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));

  
}
