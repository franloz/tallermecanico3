import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/controller/repairordercontroller.dart';
import 'package:tallermecanico/model/repairorder.dart';


class RepairOrdersInsertView extends StatefulWidget {
  const RepairOrdersInsertView({Key? key}) : super(key: key);

  @override
  State<RepairOrdersInsertView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairOrdersInsertView> {
  //DatabaseSqlite dt = DatabaseSqlite();
  RepairOrderController cr=RepairOrderController();

  TextEditingController horasreparaciontxt = TextEditingController();
  TextEditingController preciohoratxt = TextEditingController();
  TextEditingController descripcionreparaciontxt = TextEditingController();

  String? mecanico; //values combobox
  String? vehiculo;

  String inicio = 'Inicio';
  String fin = 'Fin';

  var datestart;
  var dateend;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla

    List<String> listamecanicos = parametros!["listamecanicos"];
    List<String> listavehiculos = parametros["listavehiculos"];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Text('Añadir Orden de Reparación'),
        ),
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                    width: size.width / 1.1,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Elige vehículo',
                          style: TextStyle(color: Colors.white)),
                      value: vehiculo,
                      items: listavehiculos
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => vehiculo = item),
                    ))
                //se convierte la lista de String a DropdownMenuItem<String>
              ],
            ),

            const SizedBox(
              height: 8,
            ), //para separar rows

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                    width: size.width / 1.1,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Elige mecánico',
                          style: TextStyle(color: Colors.white)),
                      value: mecanico,
                      items: listamecanicos
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => mecanico = item),
                    ))
                //se convierte la lista de String a DropdownMenuItem<String>
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                      ], //para que solo se pueda poner un punto
                      controller:
                          horasreparaciontxt, //se identifica el controlador del TextField
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
            ), //para separar rows

            Row(
              mainAxisAlignment:MainAxisAlignment.center, //Center Row contents horizontally,
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
                      inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),],
                      controller: preciohoratxt, //se identifica el controlador del TextField
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
            ),

            Row(
              //fila con un container y un TextField para contraseña
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                  height: size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(  Radius.circular(20)), //bordes circulares
                    color: Colors.grey[700],
                  ),
                  child: TextField(
                      controller: descripcionreparaciontxt, //se identifica el controlador del TextField
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
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),

            Row(
              //fila con un container y un TextField para contraseña
              mainAxisAlignment:MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                Container(
                  width: size.width / 3,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      datestart = await pickDateStart(context);//captura la fecha que se elige en el calendario
                      setState(() {
                        if (datestart != null) {//si se escoge fecha se introduce en variable inicio
                          inicio = DateFormat('yyyy-MM-dd').format(datestart!);
                        } else {//sino  se escoge fecha se introduce en variable inicio un string que indica que está vacia
                          inicio = 'Inicio';
                        }
                      });
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      inicio,
                      style: TextStyle(
                          fontSize: size.height / 65, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width / 13,
                ),
                Container(
                    width: size.width / 3,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        dateend = await pickDateEnd(context, datestart);
                        setState(() {
                          if (dateend != null) {
                            fin = DateFormat('yyyy-MM-dd').format(dateend!);
                          } else {
                            fin = 'Fin';
                          }
                        });
                      },
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        fin,
                        style: TextStyle(
                            fontSize: size.height / 65, color: Colors.white),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 8,
            ), //para separar rows
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                TextButton(
                  onPressed: () async {
                    if (mecanico == null ||
                        vehiculo == null ||
                        datestart == null) {
                      String error ='Debe elegir al mecánico, el vehículo y la fecha de inicio';
                      DialogError dialogError = DialogError();
                      await dialogError.dialogError(context, error);
                    } else {
                      

                      String id = vehiculo.toString() + '//' + inicio;//se crea id a partir de matricula y fecha de incio

                      var order = RepairOrder(
                          id: id.toUpperCase(),
                          vehiculo: vehiculo.toString(),
                          mecanico: mecanico.toString(),
                          horasreparacion: horasreparaciontxt.text,
                          preciohora: preciohoratxt.text,
                          descripcionreparacion: descripcionreparaciontxt.text,
                          inicio: inicio,
                          fin: fin,
                          facturada: 0 //facturada 0 significa que no ha sido facturada
                          );

                      await cr.insertOrder(context, order);

                      horasreparaciontxt.clear();
                      descripcionreparaciontxt.clear();
                      preciohoratxt.clear();
                      

                      Navigator.of(context).pop();
                    }
                  }, 
                  child: Text('Guardar',
                      style: TextStyle(
                          fontSize: size.height / 35,
                          color: Colors
                              .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                ),
              ],
            ),
          ],
        ));
  }

  Future<DateTime?> pickDateStart(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),//fecha que muestra al abrir widget
      firstDate: DateTime(2020),//fecha minima
      lastDate: DateTime(2200));//fecha maxima
  Future<DateTime?> pickDateEnd(BuildContext context, DateTime datestart) =>
      showDatePicker(
          context: context,
          initialDate: datestart,
          firstDate: datestart,
          lastDate: DateTime(2200));
}
