import 'package:flutter/material.dart';

import 'package:tallermecanico/databases/database.dart';

class DialogRepairLinesDelete {
  DatabaseSqlite dt = DatabaseSqlite();

  Future dialogOrderDelete(BuildContext context, String idorden, String idlinea,
          String idrecambio, int cantidad) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title:
                    Text('Borrar Línea', style: TextStyle(color: Colors.white)),
                content: Text('¿Estas seguro de borrar esta línea?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await dt.deleteLines(idorden, idlinea, idrecambio, cantidad);

                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
}
