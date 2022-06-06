import 'package:flutter/material.dart';

import '../../controller/repairordercontroller.dart';

class DialogRepairOrderDelete {
  RepairOrderController cr=RepairOrderController();

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
                  await cr.deleteOrder(context, id);

                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));

  
}
