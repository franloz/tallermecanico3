import 'package:flutter/material.dart';

import '../../controller/vehiclecontroller.dart';

class DialogVehicles {
  VehicleController cr=VehicleController();

  Future dialogVehicleDelete(BuildContext context, String dni) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar vehícule', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este vehículo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await cr.deleteVehicle(context, dni);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
