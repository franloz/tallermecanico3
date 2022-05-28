import 'package:flutter/material.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/firebasedatabase.dart';
import 'package:tallermecanico/model/repairorder.dart';

class DialogBills {


  FirebaseDatabase base = FirebaseDatabase();


  String? orden;//values combobox

  Future dialogBillsInsert(BuildContext context, Size size, List<String> listaordenes) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(
              builder: ((context, setState) => AlertDialog(
                    backgroundColor: Colors.grey[600],
                    title: Text('Elija la orden que quiere facturar',
                        style: TextStyle(color: Colors.white)),
                    //content: Text(error),
                    actions: <Widget>[
                      Container(
                          width: size.width / 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                      width: size.width / 1.4,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('Elige orden'),
                                        value: orden,
                                        items: listaordenes
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item),
                                                ))
                                            .toList(),
                                        onChanged: (item) =>
                                            setState(() => orden = item),
                                      ))
                                  //se convierte la lista de String a DropdownMenuItem<String>
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ), //para separar rows

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (orden ==null) {
                                        String error =
                                            'Debe elegir orden';
                                        DialogError dialogError = DialogError();
                                        dialogError.dialogError(context, error);
                                      } else {
                                        String idorden=orden.toString();

                                        base.insertBill(context,idorden);
                                        

                                        Navigator.of(context).pop();
                                      }
                                    }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                    child: Text('Guardar',
                                        style: TextStyle(
                                            fontSize: size.height / 35,
                                            color: Colors
                                                .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ))));

/*
  Future dialogSpareDelete(BuildContext context, String id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Mecánico', style: TextStyle(color: Colors.white)),
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
                  base.deleteSpare(id);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));*/


  
}
