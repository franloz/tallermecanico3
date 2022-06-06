import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/repairorder.dart';

import '../../../controller/repairordercontroller.dart';

class RepairOrdersUpdateView extends StatefulWidget {
  const RepairOrdersUpdateView({Key? key}) : super(key: key);

  @override
  State<RepairOrdersUpdateView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairOrdersUpdateView> {
  RepairOrderController cr=RepairOrderController();

  String? idmecanico;
  String fechafin = 'Fin';
  var dateend;

  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla
    TextEditingController horasreparaciontxt = TextEditingController();
    TextEditingController preciohoratxt = TextEditingController();
    TextEditingController descripcionreparaciontxt = TextEditingController();

    horasreparaciontxt = parametros!["horasreparaciontxt"];
    preciohoratxt = parametros["preciohoratxt"];
    descripcionreparaciontxt = parametros["descripcionreparaciontxt"];

    List<String> listamecanicos = parametros["listamecanicos"];

    String idord = parametros["id"];
    String vehiculomatri = parametros["vehiculo"];
    String fechainicio = parametros["fechainicio"];
    String fin = parametros["fechafin"];

    String mecanicoactual = parametros["mecanico"];

    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Actualizar orden'),
        ),
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ), //para separar rows
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Text('Mecánico actual: ' + mecanicoactual,
                    style: TextStyle(
                        fontSize: size.height / 45, color: Colors.white))
              ],
            ),

            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                    width: size.width / 1.1,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Elige mecánico',
                          style: TextStyle(color: Colors.white)),
                      value: idmecanico,
                      items: listamecanicos
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => idmecanico = item),
                    ))
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width / 1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]+[.]{0,1}[0-9]*')),],
                      controller: horasreparaciontxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Horas reparación",
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow( RegExp(r'[0-9]+[.]{0,1}[0-9]*')),],
                      controller:preciohoratxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Precio hora",
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment:MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller:descripcionreparaciontxt, //se identifica el controlador del TextField
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 229, 255)),
                          ),
                          prefixIcon: Icon(Icons.circle_outlined),
                          border: InputBorder.none,
                          hintText: "Descripción de la reparación",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(//indica el mecanico actual porque debe de volver a elegirlo en el combobox sino quiere modificarlo
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Text('Fecha de fin actual: ' + fin, style: TextStyle(fontSize: size.height / 45, color: Colors.white))
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                children: [
                  Container(
                      width: size.width / 3,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          DateTime date = DateTime.parse( fechainicio); //convierto la fecha de inicio a datetime para pasarla al metodo pickDateEnd

                          dateend = await pickDateEnd(context, date);
                          setState(() {
                            if (dateend != null) {
                              fechafin =
                                  DateFormat('yyyy-MM-dd').format(dateend!);
                            } else {
                              fechafin = 'Fin';
                            }
                          });
                        },
                        icon: Icon(Icons.calendar_today),
                        label: Text(
                          fechafin,
                          style: TextStyle(
                              fontSize: size.height / 65, color: Colors.white),
                        ),
                      )),
                ]),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment:MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                TextButton(
                  onPressed: () async {
                    if (idmecanico == null) {
                      String error = 'Debe elegir al mecánico';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {
                      var order = RepairOrder(
                        id: idord,
                        vehiculo: vehiculomatri,
                        mecanico: idmecanico.toString(),
                        horasreparacion: horasreparaciontxt.text,
                        preciohora: preciohoratxt.text,
                        descripcionreparacion: descripcionreparaciontxt.text,
                        inicio: fechainicio,
                        fin: fechafin,
                        facturada: 0,
                      );

                      await cr.updateOrder(context, order, idord);

                      descripcionreparaciontxt.clear();
                      horasreparaciontxt.clear();
                      preciohoratxt.clear();

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Guardar',
                      style: TextStyle(
                          fontSize: size.height / 35,
                          color: Colors
                              .white)), 
                ),
              ],
            ),
          ],
        ));
  }

  Future<DateTime?> pickDateEnd(BuildContext context, DateTime datestart) =>
      showDatePicker(
          context: context,
          initialDate: datestart,
          firstDate: datestart,
          lastDate: DateTime(2200));
}
