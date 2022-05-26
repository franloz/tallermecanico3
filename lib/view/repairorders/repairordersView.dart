/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/repairorders/dialogRepairOrder.dart';

class RepairOrdersView extends StatelessWidget {
  const RepairOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DialogRepairOrder dialog = DialogRepairOrder();

  TextEditingController searchtxt = TextEditingController();

  String search = '';


  DatabaseSqlite dt = DatabaseSqlite();
  List<String> listamecanicos = [];
  List<String> listavehiculos = [];


  @override
  void initState() {
    //en este init obtengo los dni de los clientes y los introduzco en una lista para poder mostrarlos en el dropdownmenuitem (combobox) de la pantalla DialogVehicle
    //se convierte una lista de map en una lista de string
    dt.getMechanicdni().then((listMap) {
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


    dt.getVehiclesmatricula().then((listMap) {
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
            backgroundColor: Color.fromARGB(255, 0, 229, 255),
            title: Container(
              width: double.infinity,
              height: 40,
              child: Center(
                child: TextField(
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
                    hintText: 'Matrícula del vehículo a buscar en minúscula',
                  ),
                ),
              ),
            )),
        backgroundColor: Colors.grey[800],
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 229, 255),
            child: Icon(Icons.add),
            onPressed: () {
              FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
              dialog.dialogRepairOrdersInsert(context,size,listamecanicos,listavehiculos); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
              //setState(() {});
            }),
        body: StreamBuilder<QuerySnapshot>(
          stream: loadList(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                String numeroorden = data['numeroorden'];
                String vehiculo = data['vehiculo'];
                String mecanico = data['mecanico'];
                String horasdedicadas = data['horasdedicadas'];
                String descripcionreparacion = data['descripcionreparacion'];
               // DateTime datefirebaseinicio = DateTime.parse(data['fechainicio'].toDate().toString()); //convierto el timestamp de firebase a dattime
                //String fechainicio =DateFormat('dd-MM-yyyy').format(datefirebaseinicio);
                String fechainicio=data['fechainicio'];

                //DateTime datefirebasefin = DateTime.parse(data['fechafin'].toDate().toString()); //convierto el timestamp de firebase a dattime
                //String fechafin =DateFormat('dd-MM-yyyy').format(datefirebasefin);
                String fechafin=data['fechafin'];

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(
                              numeroorden,
                              vehiculo,
                              mecanico,
                              horasdedicadas,
                              descripcionreparacion,
                              fechainicio,
                              fechafin);
                        },
                        leading: Icon(Icons.assignment_sharp),
                        title: Text(numeroorden),
                        subtitle: Text(vehiculo),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco
                                    //le asigno a los controladores del alertdialog los valores del usuario a modificar para que aparezcan escriyos en los textFields del dialog

                                    /* TextEditingController marcacontroll =
                                        TextEditingController();
                                    TextEditingController piezacontroll =
                                        TextEditingController();
                                    TextEditingController preciocontroll =
                                        TextEditingController();
                                    TextEditingController stockcontroll =
                                        TextEditingController();
                                    TextEditingController
                                        telfproveedorcontroll =
                                        TextEditingController();
                                    marcacontroll.text = marca;
                                    piezacontroll.text = pieza;
                                    preciocontroll.text = precio.toString();
                                    stockcontroll.text = stock.toString();
                                    telfproveedorcontroll.text =
                                        telfproveedor.toString();
                                    await dialog.dialogSpareUpdate(
                                        context,
                                        size,
                                        marcacontroll,
                                        piezacontroll,
                                        preciocontroll,
                                        stockcontroll,
                                        telfproveedorcontroll,
                                        id); //este ultimo dni q le paso es para identificar que registro actualizo*/
                                    //setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco
                                    /*print(id);
                                    await dialog.dialogSpareDelete(context, id);*/
                                    //setState(() {});
                                  }),
                            ],
                          ),
                        )));
              }).toList(),
            );
          },
        ));
  }

  void bottomSheet(
      String numeroorden,
      String vehiculo,
      String mecanico,
      String horasdedicadas,
      String descripcionreparacion,
      String fechainicio,
      String fechafin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,//para que entren todos los elementos en el bottomsheet
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,//para que entren todos los elementos en el bottomsheet
        children: [
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

  Stream<QuerySnapshot> loadList() {
    if (search != '') {
      print(search.toUpperCase());
      return FirebaseFirestore.instance
          .collection('repairorders')
          .where('vehiculo', isEqualTo: search)
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('repairorders').snapshots();
    }
  }
}*/
