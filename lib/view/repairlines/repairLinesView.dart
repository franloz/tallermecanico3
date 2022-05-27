import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/repairLines.dart';
import 'package:tallermecanico/model/repairorder.dart';
import 'package:tallermecanico/view/repairorders/dialogRepairOrder.dart';

class RepairLinesView extends StatelessWidget {
  const RepairLinesView({Key? key}) : super(key: key);

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
  
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map? parametros = ModalRoute.of(context)?.settings.arguments as Map?;//para coger el argumento q se pasa desde la otra pantalla

    String idorden = parametros!["idorden"];
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
                        FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
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
            onPressed: () async{
              FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
             // await dialog.dialogRepairOrdersInsert(context, size, listamecanicos,listavehiculos); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
              setState(() {});
            }),
        body: FutureBuilder<List<RepairLines>>(
          future: loadList(idorden), ////un metodo que controle si hay busqueda o no
          builder:
              (BuildContext context, AsyncSnapshot<List<RepairLines>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((line) {
                String idorden = line.idorden;
                String idlinea =line.idlinea;
                String idrecambio =line.idrecambio;
                String cantidad =line.cantidad;
                

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

                          bottomSheet( idorden, idlinea, idrecambio, cantidad);
                        },
                        
                        leading: Icon(Icons.car_repair),
                        title: Text(idorden),
                        subtitle: Text(idrecambio),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                   // await dialog.dialogOrderDelete(context, id);
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

  void bottomSheet(
      String idorden,
      String idlinea,
      String idrecambio,
      String cantidad,
      ) {
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
            subtitle: Text(idorden),
          ),
          ListTile(
            title: Text('Id línea'),
            subtitle: Text(idlinea),
          ),
          ListTile(
            title: Text('Id recambio'),
            subtitle: Text(idrecambio),
          ),
          ListTile(
            title: Text('Cantidad'),
            subtitle: Text(cantidad),
          ),
          
        ],
      ),
    );
  }


  Future<List<RepairLines>> loadList(String idorden ) async {
    /*if (search != '') {
      return dt.getLinesWhere(search);
    } else {*/
      return dt.getLines(idorden);
   // }
  }
  
}