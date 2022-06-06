import 'package:flutter/material.dart';


import '../../controller/repairlinecontroller.dart';

class DialogRepairLinesDelete {
  RepairLineController cr=RepairLineController();

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
                      await cr.deleteLines(idorden, idlinea, idrecambio, cantidad);

                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
}
