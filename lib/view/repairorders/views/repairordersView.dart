import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/model/repairorder.dart';
import 'package:tallermecanico/view/repairorders/dialogRepairOrderDelete.dart';

import '../../../controller/repairordercontroller.dart';
import '../../../databases/database.dart';

class RepairOrdersView extends StatefulWidget {
  const RepairOrdersView({Key? key}) : super(key: key);

  @override
  State<RepairOrdersView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairOrdersView> {

  RepairOrderController cr=RepairOrderController();

  DialogRepairOrderDelete dialog = DialogRepairOrderDelete();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

  DatabaseSqlite dt = DatabaseSqlite();
  List<String> listamecanicos = [];
  List<String> listavehiculos = [];
  @override
  void initState() {
    //en este init obtengo los dni de los clientes y los introduzco en una lista para poder mostrarlos en el dropdownmenuitem (combobox) de la pantalla DialogVehicle
    //se convierte una lista de map en una lista de string
    cr.getMechanicdni().then((listMap) {
      listMap.map((map) {
        print('fggfg');
        print(map.toString());

        return map['dni'];
      }).forEach((dropDownItem) {
        listamecanicos.add(dropDownItem);
        print(dropDownItem.toString());
      });
      setState(() {});
    });

    cr.getVehiclesmatricula().then((listMap) {
      listMap.map((map) {
        print('fggfg');
        print(map.toString());

        return map['matricula'];
      }).forEach((dropDownItem) {
        listavehiculos.add(dropDownItem);
        print(dropDownItem.toString());
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          title: Container(
            width: double.infinity,
            height: 40,
            child: Center(
              child: TextField(
                onChanged: (value) {
                 
                  search = searchtxt.text;
                  setState(() {});//al cambiar el valor del textfield busca
                    
                },
                controller: searchtxt,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context)
                          .unfocus(); //para que el textfield pierda el foco
                      search = searchtxt.text;
                      setState(() {});
                    },
                  ),
                  hintText: 'Matrícula del vehículo a buscar',
                ),
              ),
            ),
          )),
      backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          child: Icon(Icons.add),
          onPressed: () async {
            FocusScope.of(context) .unfocus(); //para que el textfield pierda el foco
            

            await Navigator.pushNamed(context, 'RepairOrdersInsertView',
                arguments: {
                  "listamecanicos": listamecanicos,
                  "listavehiculos": listavehiculos,
                });
            setState(() {});
          }),
      body: FutureBuilder<List<RepairOrder>>(
          future: loadList(), ////un metodo que controle si hay busqueda o no
          builder: (BuildContext context,
              AsyncSnapshot<List<RepairOrder>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((order) {
                String id = order.id;
                String vehiculo = order.vehiculo;
                String? mecanico = order.mecanico; //? para combobox
                String horasreparacion = order.horasreparacion;
                String preciohora = order.preciohora;
                String descripcionreparacion = order.descripcionreparacion;
                String fechainicio = order.inicio;
                String fechafin = order.fin;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

                          bottomSheet(
                              id,
                              vehiculo,
                              mecanico,
                              horasreparacion,
                              preciohora,
                              descripcionreparacion,
                              fechainicio,
                              fechafin,
                              size);
                        },
                        onLongPress: () {
                          
                          Navigator.pushNamed(context, 'RepairLinesView', arguments: {"idorden": id});
                        },
                        leading: Icon(Icons.car_repair),
                        title: Text(id),
                        subtitle: Text('Matrícula: ' + vehiculo),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    Database database = await dt.openDB();
                                    var resultSet = await database.rawQuery("SELECT facturada FROM OrdenesReparacion WHERE id = ?", [id]);
                                    // Get first result
                                    var dbItem = resultSet.first;
                                    // Access its id
                                    var facturada = dbItem['facturada'] as int;

                                    if (facturada == 0) {
                                      //si facturada es igual a 0 significa q no esta facturada y se puede editar

                                      FocusScope.of(context) .unfocus(); //para que el textfield pierda el foco

                                      //le asigno a los controladores de la siguiente pantalla los valores a modificar para que aparezcan escriyos en los textFields del dialog
                                      TextEditingController horasreparaciontxt = TextEditingController();
                                      TextEditingController descripcionreparaciontxt = TextEditingController();
                                      TextEditingController preciohoratxt = TextEditingController();

                                      horasreparaciontxt.text = horasreparacion;
                                      descripcionreparaciontxt.text = descripcionreparacion;
                                      preciohoratxt.text = preciohora;

                                      await Navigator.pushNamed(
                                          context, 'RepairOrdersUpdateView',
                                          arguments: {
                                            "listamecanicos": listamecanicos,
                                            "horasreparaciontxt":horasreparaciontxt,
                                            "preciohoratxt": preciohoratxt,
                                            "descripcionreparaciontxt": descripcionreparaciontxt,
                                            "fechafin": fechafin,
                                            "mecanico": mecanico,
                                            "id": id,
                                            "vehiculo": vehiculo,
                                            "fechainicio": fechainicio,
                                          });
                                      setState(() {});
                                    } else {
                                      String error = 'Las órdenes que han sido facturadas no se pueden borrar';
                                      DialogError dialogError = DialogError();
                                      await dialogError.dialogError( context, error);
                                    }
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    Database database = await dt.openDB();
                                    var resultSet = await database.rawQuery( "SELECT facturada FROM OrdenesReparacion WHERE id = ?",[id]);
                                    // Get first result
                                    var dbItem = resultSet.first;
                                    // Access its id
                                    var facturada = dbItem['facturada'] as int;

                                    if (facturada == 0) {
                                      //si facturada es igual a 0 significa q no esta facturada y se puede borrar, si no es igual a 0 no se puede borrar

                                      FocusScope.of(context)
                                          .unfocus(); //para que el textfield pierda el foco
                                      await dialog.dialogOrderDelete(
                                          context, id);
                                      setState(() {});
                                    } else {
                                      String error =
                                          'Las órdenes que han sido facturadas no se pueden borrar';
                                      DialogError dialogError = DialogError();
                                      await dialogError.dialogError(
                                          context, error);
                                    }
                                  }),
                            ],
                          ),
                        )));
              }).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),

     
    );
  }

  void bottomSheet(
      String numeroorden,
      String vehiculo,
      String mecanico,
      String horasdedicadas,
      String preciohora,
      String descripcionreparacion,
      String fechainicio,
      String fechafin,
      Size size) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, //para que entren todos los elementos en el bottomsheet
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize
            .min, //para que entren todos los elementos en el bottomsheet
        children: [
          const SizedBox(
            height: 20,
          ),
          Text('Mantenga pulsada la orden para acceder a sus líneas',
              style:
                  TextStyle(fontSize: size.height / 55, color: Colors.black)),
          ListTile(
            title: Text('Id de orden'),
            subtitle: Text(numeroorden),
          ),
          ListTile(
            title: Text('Matrícula del vehículo'),
            subtitle: Text(vehiculo),
          ),
          ListTile(
            title: Text('Dni mecánico'),
            subtitle: Text(mecanico),
          ),
          ListTile(
            title: Text('Horas dedicadas al vehículo'),
            subtitle: Text(horasdedicadas),
          ),
          ListTile(
            title: Text('Precio hora'),
            subtitle: Text(preciohora),
          ),
          ListTile(
            title: Text('Descripción de la reparación'),
            subtitle: Text(descripcionreparacion),
          ),
          ListTile(
            title: Text('Fecha de inicio de la reparación'),
            subtitle: Text(fechainicio.toString()),
          ),
          ListTile(
            title: Text('Fecha de fin de la reparación'),
            subtitle: Text(fechafin.toString()),
          ),
        ],
      ),
    );
  }

  Future<List<RepairOrder>> loadList() async {
    if (search != '') {
      return cr.getOrderWhere(search);
    } else {
      return cr.getOrders();
    }
  }
  
}
