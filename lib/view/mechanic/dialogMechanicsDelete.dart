import 'package:flutter/material.dart';

import '../../controller/mechaniccontroller.dart';

class DialogMechanicsDelete {
  MechanicController cr=MechanicController();


  TextEditingController dnitxt = TextEditingController();
  TextEditingController nombretxt = TextEditingController();
  TextEditingController telftxt =TextEditingController(); //variables para coger los textos de los TextField
  TextEditingController direcciontxt = TextEditingController();

  Future dialogMechanicDelete(BuildContext context, String dni) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Mecánico', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar este mecánico?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await cr.deleteMechanic(context, dni);//metodo para borrar en base de datos
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));
}
