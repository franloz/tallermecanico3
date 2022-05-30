import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/clients/dialogClientsDelete.dart';

import '../../model/client.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({Key? key}) : super(key: key);

  @override
  State<ClientsView> createState() => _ScreenState();
}

class _ScreenState extends State<ClientsView> {
  DialogClientsDelete cl = DialogClientsDelete();//alertdialog para insertar, modificar y eliminar clientes
  DatabaseSqlite dt = DatabaseSqlite();

  TextEditingController searchtxt = TextEditingController();//textedit donde se hará la búsqueda del cliente

  String search = '';//esta variable se usará para buscar en la lista de clientes

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
                      FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

                      search = searchtxt.text;
                      setState(() {});//para actualizar la vista
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
            FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
            //await cl.dialogClientInsert(context,size); 
            await Navigator.pushNamed(context, 'ClientInsertView');//con el await hacemos q espere a q se cierre ClientInsertView para seguir ejecutando el codigo en este caso el setstate
            setState(() {});
          }),
      body: FutureBuilder<List<Client>>(
          future:loadList(), //un metodo que controle si hay busqueda o no
          builder:
              (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((client) {
                //variables donde se introducen los datos de los objetos de la lista
                String dni = client.dni;
                String name = client.nombre;
                int tlf = client.telf;
                String direccion = client.direccion;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                          bottomSheet(dni, name, tlf, direccion);//metodo para mostrar los datos de los clientes
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
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                    //le asigno a los controladores del alertdialog los valores del cliente a modificar para que aparezcan escrios en los textFields del dialog de modificar
                                    
                                    TextEditingController namecontroll =TextEditingController();
                                    namecontroll.text = name;
                                    TextEditingController tlfcontroll =TextEditingController();
                                    tlfcontroll.text = tlf.toString();
                                    TextEditingController direccioncontroll =TextEditingController();
                                    direccioncontroll.text = direccion;
                                   /* await cl.dialogClientUpdate(//alertdialog para actualizar
                                        context,
                                        size,
                                        dni,
                                        namecontroll,
                                        tlfcontroll,
                                        direccioncontroll); */
                                        await Navigator.pushNamed(context, 'ClientUpdateView',arguments: {
                                          "dni": dni,
                                          "namecontroll":namecontroll,
                                          "tlfcontroll":tlfcontroll,
                                          "direccioncontroll":direccioncontroll,
                                          
                                          
                                          });
                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                    await cl.dialogClientDelete(context, dni);//dialog para borrar
                                    setState(() {});
                                  }),
                            ],
                          ),
                        )));
              }).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),//símbolo de carga
              );
            }
          }),
    );
  }

  Future<List<Client>> loadList() async {//metodo para mostrar la lista de clientes
    if (search != '') {//si se introduce texto en el textfield de busqueda llama al metodo getClientsWhere que filtra la lista de clientes
      return dt.getClientsWhere(search);
    } else {
      return dt.getClients();
    }
  }

  void bottomSheet(String dni, String name, int tlf, String direccion) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
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
