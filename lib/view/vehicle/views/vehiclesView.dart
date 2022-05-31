import 'package:flutter/material.dart';
import 'package:tallermecanico/view/vehicle/dialogVehicles.dart';

import '../../../controller/vehiclecontroller.dart';
import '../../../model/vehicle.dart';

class VehiclesView extends StatefulWidget {
  const VehiclesView({Key? key}) : super(key: key);

  @override
  State<VehiclesView> createState() => _ScreenState();
}

class _ScreenState extends State<VehiclesView> {
  DialogVehicles cl = DialogVehicles();
  //DatabaseSqlite dt = DatabaseSqlite();
  VehicleController cr=VehicleController();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

  final List<String> lista = [];
  @override
  void initState() {
    //en este init obtengo los dni de los clientes y los introduzco en una lista para poder mostrarlos en el dropdownmenuitem (combobox) de la pantalla DialogVehicle
    //se convierte una lista de map en una lista de string
    cr.getClientsdni().then((listMap) {
      listMap.map((map) {
        print('fggfg');
        print(map.toString());

        return map['dni'];
      }).forEach((dropDownItem) {
        lista.add(dropDownItem);
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
                  search = searchtxt.text; //al cambiar el valor del textfield busca
                  setState(() {});
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
            FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

            await Navigator.pushNamed(context, 'VehicleInsertView', arguments: {
              "lista": lista,
            });

            setState(() {});
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
                        subtitle: Text(marca + ' ' + modelo),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco

                                    TextEditingController marcacontroll =
                                        TextEditingController();
                                    TextEditingController modelocontroll =
                                        TextEditingController();
                                    marcacontroll.text = marca;
                                    modelocontroll.text = modelo;

                                    await Navigator.pushNamed(
                                        context, 'VehicleUpdateView',
                                        arguments: {
                                          "matricula": matricula,
                                          "marcacontroll": marcacontroll,
                                          "clientedni": clientedni.toString(),
                                          "modelocontroll": modelocontroll,
                                          "lista": lista,
                                        });
                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
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
      return cr.getVehicleWhere(search);
    } else {
      return cr.getVehicles();
    }
  }

  void bottomSheet(
      String matricula, String marca, String modelo, String clientedni) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
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
}
