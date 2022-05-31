import 'package:flutter/material.dart';
import 'package:tallermecanico/view/mechanic/dialogMechanicsDelete.dart';

import '../../../controller/mechaniccontroller.dart';
import '../../../model/mechanic.dart';

class MechanicsView extends StatefulWidget {
  const MechanicsView({Key? key}) : super(key: key);

  @override
  State<MechanicsView> createState() => _ScreenState();
}

class _ScreenState extends State<MechanicsView> {
  DialogMechanicsDelete dialog = DialogMechanicsDelete();
  //DatabaseSqlite dt = DatabaseSqlite();
  MechanicController cr=MechanicController();


  TextEditingController searchtxt = TextEditingController();//textedit donde se hará la búsqueda del mecanico

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
                      setState(() {});
                    },
                  ),
                  hintText: 'Nombre del mecánico a buscar',
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
             
            await Navigator.pushNamed(context, 'MechanicInsertView');//con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
            setState(() {});
          }),
      body: FutureBuilder<List<Mechanic>>(
          future: loadList(), ////un metodo que controle si hay busqueda o no
          builder:
              (BuildContext context, AsyncSnapshot<List<Mechanic>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((mechanic) {
                    //variables donde se introducen los datos de los objetos de la lista
                String dni = mechanic.dni;
                String name = mechanic.nombre;
                int tlf = mechanic.telf;
                String direccion = mechanic.direccion;

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
                                    //le asigno a los controladores del alertdialog los valores del usuario a modificar para que aparezcan escritos en los textFields de la pantalla actualizar
                                    
                                    TextEditingController namecontroll =TextEditingController();
                                    namecontroll.text = name;
                                    TextEditingController tlfcontroll =TextEditingController();
                                    tlfcontroll.text = tlf.toString();
                                    TextEditingController direccioncontroll =TextEditingController();
                                    direccioncontroll.text = direccion;
                                    
                                    await Navigator.pushNamed(context, 'MechanicUpdateView',arguments: {//envio parametros a otra pantalla
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
                                    await dialog.dialogMechanicDelete(context, dni);//dialog para borrar
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

  Future<List<Mechanic>> loadList() async {//metodo para mostrar la lista de clientes
    if (search != '') {
      return cr.getMechanicWhere(search);//si se introduce texto en el textfield de busqueda llama al metodo getClientsWhere que filtra la lista de clientes
    } else {
      return cr.getMechanics();
    }
  }

  void bottomSheet(String dni, String name, int tlf, String direccion) {
    showModalBottomSheet(
      isScrollControlled:
          true, 
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize
            .min,
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


