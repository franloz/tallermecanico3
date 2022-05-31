import 'package:flutter/material.dart';
import 'package:tallermecanico/databases/database.dart';

class DialogSpareDelete {
  DatabaseSqlite dt = DatabaseSqlite();

  Future dialogSpareDelete(BuildContext context, String id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Recambio', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este recambio?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await dt.deleteSpare(context, id);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
