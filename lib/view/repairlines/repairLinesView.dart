import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/repairLines.dart';
import 'package:tallermecanico/view/repairlines/dialogRepairLinesDelete.dart';

class RepairLinesView extends StatefulWidget {
  const RepairLinesView({Key? key}) : super(key: key);

  @override
  State<RepairLinesView> createState() => _ScreenState();
}

class _ScreenState extends State<RepairLinesView> {
  DialogRepairLinesDelete dialog = DialogRepairLinesDelete();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

  DatabaseSqlite dt = DatabaseSqlite();
  List<String> listarecambios = [];
  @override
  void initState() {
    //en este init obtengo los dni de los clientes y los introduzco en una lista para poder mostrarlos en el dropdownmenuitem (combobox) de la pantalla DialogVehicle
    //se convierte una lista de map en una lista de string
    dt.getRecambiosId().then((listMap) {
      listMap.map((map) {
        print('fggfg');
        print(map.toString());

        return map['id'];
      }).forEach((dropDownItem) {
        listarecambios.add(dropDownItem);
        print(dropDownItem.toString());
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map? parametros = ModalRoute.of(context)?.settings.arguments
        as Map?; //para coger el argumento q se pasa desde la otra pantalla

    String idorden = parametros!["idorden"];
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
                  hintText: 'Id del Recambio a buscar',
                ),
              ),
            ),
          )),
      backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          child: Icon(Icons.add),
          onPressed: () async {
            FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

            Database database = await dt.openDB();
            var resultSet = await database.rawQuery("SELECT facturada FROM OrdenesReparacion WHERE id = ?",[idorden]);//compruebo si esta orden está facturada
            // Get first result
            var dbItem = resultSet.first;
            // Access its id
            var facturada = dbItem['facturada'] as int;

            if (facturada == 0) {
              //si facturada es igual a 0 significa q no esta facturada y se puede insertar lineas, si no es igual a 0 no se puede insertar lineas
              
              await Navigator.pushNamed(context, 'RepairLinesInsertView',
                  arguments: {
                    "listarecambios": listarecambios,
                    "idorden": idorden,
                  });
              setState(() {});
            } else {
              String error =
                  'No se pueden insertar lineas en las ordenes facturadas';
              DialogError dialogError = DialogError();
              await dialogError.dialogError(context, error);
            }
          }),
      body: FutureBuilder<List<RepairLines>>(
          future:
              loadList(idorden), ////un metodo que controle si hay busqueda o no
          builder: (BuildContext context,
              AsyncSnapshot<List<RepairLines>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((line) {
                String idorden = line.idorden;
                String idlinea = line.idlinea;
                String idrecambio = line.idrecambio;
                int cantidad = line.cantidad;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context) .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(idorden, idlinea, idrecambio, cantidad);
                        },
                        leading: Icon(Icons.miscellaneous_services_sharp),
                        title: Text(idrecambio),
                        subtitle: Text(cantidad.toString()),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    Database database = await dt.openDB();
                                    var resultSet = await database.rawQuery( "SELECT facturada FROM OrdenesReparacion WHERE id = ?",[idorden]);
                                    // Get first result
                                    var dbItem = resultSet.first;
                                    // Access its id
                                    var facturada = dbItem['facturada'] as int;

                                    if (facturada == 0) {
                                      //si facturada es igual a 0 significa q no esta facturada y se puede modificar lineas, si no es igual a 0 no se puede modificar lineas

                                      FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                      //le asigno a los controladores del alertdialog los valores del usuario a modificar para que aparezcan escriyos en los textFields de la otra pantalla
                                      TextEditingController cantidadtxt = TextEditingController();
                                      cantidadtxt.text = cantidad.toString();
                                      int cantidadold = cantidad; //le paso la cantidad vieja para sumarselo a los recambios y luego quitarle la nueva cantidad que introduzca

                                      await Navigator.pushNamed(
                                          context, 'RepairLinesUpdateView',
                                          arguments: {
                                            "idorden": idorden,
                                            "idlinea": idlinea,
                                            "idrecambio": idrecambio,
                                            "cantidadtxt": cantidadtxt,
                                            "cantidadold": cantidadold,
                                          });

                                      setState(() {});
                                    } else {
                                      String error =
                                          'No se pueden modificar lineas en las ordenes facturadas';
                                      DialogError dialogError = DialogError();
                                      await dialogError.dialogError(context, error);
                                    }
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    Database database = await dt.openDB();
                                    var resultSet = await database.rawQuery( "SELECT facturada FROM OrdenesReparacion WHERE id = ?",[idorden]);
                                    // Get first result
                                    var dbItem = resultSet.first;
                                    // Access its id
                                    var facturada = dbItem['facturada'] as int;

                                    if (facturada == 0) {
                                      //si facturada es igual a 0 significa q no esta facturada y se puede borrar lineas, si no es igual a 0 no se puede borrar lineas
                                      FocusScope.of(context)
                                          .unfocus(); //para que el textfield pierda el foco
                                      await dialog.dialogOrderDelete(
                                          context,
                                          idorden,
                                          idlinea,
                                          idrecambio,
                                          cantidad);
                                      setState(() {});
                                    } else {
                                      String error =
                                          'No se pueden borrar lineas en las ordenes facturadas';
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
    String idorden,
    String idlinea,
    String idrecambio,
    int cantidad,
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
            subtitle: Text(cantidad.toString()),
          ),
        ],
      ),
    );
  }

  Future<List<RepairLines>> loadList(String idorden) async {
    if (search != '') {
      return dt.getLinesWhere(search, idorden);
    } else {
      return dt.getLines(idorden);
    }
  }
}
