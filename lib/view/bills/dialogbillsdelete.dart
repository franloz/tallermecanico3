import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/firebasedatabase.dart';

class DialogBillsDelete {
  FirebaseDatabase base = FirebaseDatabase();

  Future dialogBillsDelete(BuildContext context, String id, String idorden) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Borrar Factura',
                    style: TextStyle(color: Colors.white)),
                content: Text('¿Estas seguro de borrar esta orden?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      base.deleteBill(id, idorden);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
}
