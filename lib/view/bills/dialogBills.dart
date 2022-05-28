import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/firebasedatabase.dart';
import 'package:tallermecanico/model/bill.dart';
import 'package:tallermecanico/model/repairorder.dart';

class DialogBills {

  TextEditingController descuentotxt = TextEditingController();
  TextEditingController ivatxt = TextEditingController();

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
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ], 
                                    controller:
                                        descuentotxt, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Descuento",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), 

                           Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ], 
                                    controller:
                                        ivatxt, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Iva",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), 
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
                                        double descuento;
                                        double iva;

                                        if(descuentotxt.text.isEmpty){
                                          descuento=0;
                                        }else{
                                          descuento=double.parse(descuentotxt.text);
                                        }

                                        if(ivatxt.text.isEmpty){
                                          iva=0;
                                        }else{
                                          iva=double.parse(ivatxt.text);
                                        }

                                        

                                        
                                        base.insertBill(context,idorden,descuento,iva);
                                        

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
