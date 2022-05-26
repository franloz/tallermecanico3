import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/clients/dialogClients.dart';

import '../../model/client.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({Key? key}) : super(key: key);

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
  DialogClients cl = DialogClients();
  DatabaseSqlite dt = DatabaseSqlite();

  TextEditingController searchtxt = TextEditingController();

  String search='';


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

                      search=searchtxt.text;
                      setState(() {});
                      
                    },
                  ),
                  hintText: 'Nombre del cliente a buscar',
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
            await cl.dialogClientInsert(context,
                size); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
            setState(() {});
          }),
      body: FutureBuilder<List<Client>>(
          future: loadList(),//dt.getClients(),//un metodo que controle si hay busqueda o no
          builder:
              (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((client) {
                String dni = client.dni;
                String name = client.nombre;
                int tlf = client.telf;
                String direccion = client.direccion;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                          .unfocus(); //para que el textfield pierda el foco
                          bottomSheet(dni, name, tlf, direccion);
                        },
                        leading: Icon(Icons.person),
                        title: Text(dni),
                        subtitle: Text(name),
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
                                    /*TextEditingController dnicontroll =
                                        TextEditingController();
                                    dnicontroll.text = dni;*/
                                    TextEditingController namecontroll =
                                        TextEditingController();
                                    namecontroll.text = name;
                                    TextEditingController tlfcontroll =
                                        TextEditingController();
                                    tlfcontroll.text = tlf.toString();
                                    TextEditingController direccioncontroll =
                                        TextEditingController();
                                    direccioncontroll.text = direccion;
                                    await cl.dialogClientUpdate(
                                        context,
                                        size,
                                        dni,
                                        namecontroll,
                                        tlfcontroll,
                                        direccioncontroll
                                        ); //este ultimo dni q le paso es para identificar que registro actualizo
                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                    await cl.dialogClientDelete(context, dni);
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

  Future<List<Client>> loadList() async{
    if(search!=''){
      return dt.getClientsWhere(search);

    }else{
      return dt.getClients();
    }

  }

  void bottomSheet(String dni, String name, int tlf, String direccion) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        children: [
          ListTile(
            title: Text('DNI'),
            subtitle: Text(dni),
          ),
          ListTile(
            title: Text('Nombre'),
            subtitle: Text(name),
          ),
          ListTile(
            title: Text('Teléfono'),
            subtitle: Text(tlf.toString()),
          ),
          ListTile(
            title: Text('Dirección'),
            subtitle: Text(direccion),
          ),
        ],
      ),
    );
  }
}
