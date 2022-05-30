/*import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/vehicle/dialogVehicles.dart';

import '../../model/Vehicle.dart';

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
  DialogRepairOrder cl = DialogRepairOrder();
  DatabaseSqlite dt = DatabaseSqlite();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

  final List<String> lista = [];
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
                  hintText: 'Matrícula a buscar',
                ),
              ),
            ),
          )),
      backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          child: Icon(Icons.add),
          onPressed: () async {
            FocusScope.of(context)
                .unfocus(); //para que el textfield pierda el foco

                for (var age in lista) {
     print('holaaaaaaaa'+age);
  }
            await cl.dialogVehicleInsert(context, size, lista); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
            setState(() {});

            //Navigator.pushNamed(context, 'VehiclesModify');
          }),
      body: FutureBuilder<List<Vehicle>>(
          future: loadList(), ////un metodo que controle si hay busqueda o no
          builder:
              (BuildContext context, AsyncSnapshot<List<Vehicle>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((mechanic) {
                String matricula = mechanic.matricula;
                String marca = mechanic.marca;
                String modelo = mechanic.modelo;
                String? clientedni = mechanic.clientedni;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(matricula, marca, modelo, clientedni);
                        },
                        leading: Icon(Icons.car_repair),
                        title: Text(matricula),
                        subtitle: Text(marca + ' modelo: ' + modelo),
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
                                    /*TextEditingController matriculacontroll =TextEditingController();*/
                                    TextEditingController marcacontroll = TextEditingController(); 
                                    TextEditingController modelocontroll =TextEditingController();
                                    /*matriculacontroll.text = matricula;*/
                                    marcacontroll.text = marca;
                                    modelocontroll.text = modelo;
                                    await cl.dialogVehicleUpdate(context,size,matricula,marcacontroll,modelocontroll,clientedni,matricula,lista); //este ultimo dni q le paso es para identificar que registro actualizo
                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco
                                    await cl.dialogVehicleDelete(
                                        context, matricula);
                                    setState(() {});
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

  Future<List<Vehicle>> loadList() async {
    if (search != '') {
      return dt.getVehicleWhere(search);
    } else {
      return dt.getVehicles();
    }
  }

  void bottomSheet(
      String matricula, String marca, String modelo, String clientedni) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        children: [
          ListTile(
            title: Text('Matricula'),
            subtitle: Text(matricula),
          ),
          ListTile(
            title: Text('Marca'),
            subtitle: Text(marca),
          ),
          ListTile(
            title: Text('Modelo'),
            subtitle: Text(modelo),
          ),
          ListTile(
            title: Text('Cliente Dni'),
            subtitle: Text(clientedni),
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/repairorder.dart';
import 'package:tallermecanico/view/repairorders/dialogRepairOrder.dart';

/*class RepairOrdersView extends StatelessWidget {
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
  List<String> listavehiculos = [];*/
class RepairOrdersView extends StatefulWidget {
  const RepairOrdersView({Key? key}) : super(key: key);

  @override
  State<RepairOrdersView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairOrdersView> {
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
          automaticallyImplyLeading: false,
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
            FocusScope.of(context)
                .unfocus(); //para que el textfield pierda el foco
            //await dialog.dialogRepairOrdersInsert(context, size, listamecanicos,
              //  listavehiculos); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate


            await Navigator.pushNamed(context, 'RepairOrdersInsertView',arguments: {
                                          "listamecanicos": listamecanicos,
                                          "listavehiculos":listavehiculos,
                                         
                                          
                                          
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
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(
                              id,
                              vehiculo,
                              mecanico,
                              horasreparacion,
                              preciohora,
                              descripcionreparacion,
                              fechainicio,
                              fechafin);
                        },
                        onLongPress: () {
                          //Navigator.pushNamed(context, 'RepairLinesView');
                          //Navigator.push(context,MaterialPageRoute(builder:((context) => RepairLinesView())));
                          Navigator.pushNamed(context, 'RepairLinesView',
                              arguments: {"idorden": id});
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
                                    var resultSet = await database.rawQuery(
                                        "SELECT facturada FROM OrdenesReparacion WHERE id = ?",
                                        [id]);
                                    // Get first result
                                    var dbItem = resultSet.first;
                                    // Access its id
                                    var facturada = dbItem['facturada'] as int;
                                    print('fac' + facturada.toString());

                                    if (facturada == 0) {
                                      //si facturada es igual a 0 significa q no esta facturada y se puede borrar, si no es igual a 0 no se puede borrar

                                      FocusScope.of(context)
                                          .unfocus(); //para que el textfield pierda el foco
                                      //le asigno a los controladores del alertdialog los valores del usuario a modificar para que aparezcan escriyos en los textFields del dialog
                                      /*TextEditingController matriculacontroll =TextEditingController();*/
                                      TextEditingController horasreparaciontxt =
                                          TextEditingController();
                                      TextEditingController
                                          descripcionreparaciontxt =
                                          TextEditingController();
                                      TextEditingController preciohoratxt =
                                          TextEditingController();

                                      horasreparaciontxt.text = horasreparacion;
                                      descripcionreparaciontxt.text =
                                          descripcionreparacion;
                                      preciohoratxt.text = preciohora;
                                      //modelocontroll.text = modelo;

                                      await dialog.dialogOrderUpdate(
                                          context,
                                          size,
                                          listamecanicos,
                                          horasreparaciontxt,
                                          preciohoratxt,
                                          descripcionreparaciontxt,
                                          fechafin,
                                          mecanico,
                                          id,
                                          vehiculo,
                                          fechainicio); //este ultimo dni q le paso es para identificar que registro actualizo
                                      setState(() {});
                                    } else {
                                      String error =
                                          'Las órdenes que han sido facturadas no se pueden borrar';
                                      DialogError dialogError = DialogError();
                                      await dialogError.dialogError(
                                          context, error);
                                    }
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    Database database = await dt.openDB();
                                    var resultSet = await database.rawQuery(
                                        "SELECT facturada FROM OrdenesReparacion WHERE id = ?",
                                        [id]);
                                    // Get first result
                                    var dbItem = resultSet.first;
                                    // Access its id
                                    var facturada = dbItem['facturada'] as int;
                                    print('fac' + facturada.toString());

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

      /*body: StreamBuilder<QuerySnapshot>(
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
                
                String fechainicio = data['fechainicio'];

                
                String fechafin = data['fechafin'];

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
        )*/
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
      String fechafin) {
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
      return dt.getOrderWhere(search);
    } else {
      return dt.getOrders();
    }
  }
  /*Stream<QuerySnapshot> loadList() {
    if (search != '') {
      print(search.toUpperCase());
      return FirebaseFirestore.instance
          .collection('repairorders')
          .where('vehiculo', isEqualTo: search)
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('repairorders').snapshots();
    }
  }*/
}
