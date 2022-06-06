import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tallermecanico/controller/clientcontroller.dart';
import 'package:tallermecanico/view/clients/dialogClientsDelete.dart';

import '../../../model/client.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({Key? key}) : super(key: key);

  @override
  State<ClientsView> createState() => _ScreenState();
}

class _ScreenState extends State<ClientsView> {
  DialogClientsDelete dialog = DialogClientsDelete();//alertdialog para eliminar clientes
  ClientController cr=ClientController();

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
                onChanged: (value) {
                 
                  search = searchtxt.text;
                  setState(() {});//al cambiar el valor del textfield busca                  
                },
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
                String nombre = client.nombre;
                int tlf = client.telf;
                String direccion = client.direccion;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                          bottomSheet(dni, nombre, tlf, direccion,size);//metodo para mostrar los datos de los clientes
                        },
                        leading: Icon(Icons.person),
                        title: Text(dni),
                        subtitle: Text(nombre),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                    //le asigno a los controladores del alertdialog los valores del cliente a modificar para que aparezcan escrios en los textFields del dialog de modificar
                                    
                                    TextEditingController nombrecontroll =TextEditingController();
                                    nombrecontroll.text = nombre;
                                    TextEditingController tlfcontroll =TextEditingController();
                                    tlfcontroll.text = tlf.toString();
                                    TextEditingController direccioncontroll =TextEditingController();
                                    direccioncontroll.text = direccion;
                                
                                        await Navigator.pushNamed(context, 'ClientUpdateView',arguments: {//con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
                                          "dni": dni,
                                          "namecontroll":nombrecontroll,
                                          "tlfcontroll":tlfcontroll,
                                          "direccioncontroll":direccioncontroll,
                                          
                                          
                                          });
                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                    await dialog.dialogClientDelete(context, dni);//dialog para borrar
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
      return cr.getClientsWhere(search);
    } else {
      return cr.getClients();
    }
  }

  void bottomSheet(String dni, String nombre, int tlf, String direccion, Size size) {
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
            subtitle: Text(nombre),
          ),
          ListTile(
            title: Text('Teléfono'),
            subtitle: Text(tlf.toString()),
          ),
          ListTile(
            title: Text('Dirección'),
            subtitle: Text(direccion),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                  icon: Icon(Icons.call), //icono del candado
                  label: Text(
                    "Llamar",
                    style: TextStyle(
                        fontSize: size.height / 33, color: Colors.white),
                  ),
                  onPressed: () async{
                    await FlutterPhoneDirectCaller.callNumber(tlf.toString());
                    
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width / 2,size.height /18), //ancho y alto del boton en relación a la pantalla
                    primary: Color.fromARGB(255, 0, 229, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),



          ],),
          SizedBox(
              height: 8,
          ),
        ],
      ),
    );
  }
}
