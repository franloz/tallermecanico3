import 'package:flutter/material.dart';
import 'package:tallermecanico/controller/clientController.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/clients/dialogClients.dart';

import '../../model/client.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

  TextEditingController nombre = TextEditingController();
  String nom = '';
  ClientController clientController = ClientController();

  String dni = '';

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
                onChanged: (text) {
                  nom = nombre.text;
                  clientController.searchDni();
                }, //si le da a intro del teclado re refresca el widget con las busquedas
                controller: nombre,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      nom = nombre
                          .text; //se coge la matricula introducida y se usa para filtrar
                      //setState(text) {};
                      //FocusManager.instance.primaryFocus
                      //?.unfocus(); //para esconder teclado, y refresca widget

                      FocusScope.of(context)
                          .unfocus(); //se elimina el foco del contexto actual y se refrescan los widget mostrando la busqueda

                      setState() {}
                      ;
                      //filtro='jj';
                    },
                  ),
                  hintText: 'Matrícula del coche a buscar',
                ),
              ),
            ),
          )),
      backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          child: Icon(Icons.add),
          onPressed: () async {
            /*await showModalBottomSheet(
                //isScrollControlled: true,
                context: context,
                shape:  RoundedRectangleBorder(
                  borderRadius:BorderRadius.vertical(top:Radius.circular(20))


                ),
                builder: (context) => Center(
                      child: ElevatedButton(
                        child: Text('k'),
                        onPressed: () {
                          var cliente = Client(
                            dni: '8',
                            nombre: 'fff',
                            telf: 5,
                            direccion: 'gggbfd',
                          );

                          dt.insertClient(cliente);
                          print('fdjfjffj');

                          Navigator.of(context).pop();
                        },
                      ),
                    ));*/
            await cl.dialogClientInsert(context,
                size); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
            setState(() {});

            //
            //setState(() {});

            ///o inserto aqui con un setstate o refresco y pongo aqui los metodos de insert
            ///
/////meter dialog aqui y metodos de add y refrescar
            print('fnfhnfh');
            //setState(() {});
          }), /////simbolo de carga
      body: FutureBuilder<List<Client>>(
          future: dt.getClients(),
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

                                  //le asigno a los controladores del alertdialog los valores del usuario a modificar para que aparezcan escriyos en los textFields del dialog
                                  TextEditingController dnicontroll=TextEditingController();
                                  dnicontroll.text=dni;
                                  TextEditingController namecontroll=TextEditingController();
                                  namecontroll.text=name;
                                  TextEditingController tlfcontroll=TextEditingController();
                                  tlfcontroll.text=tlf.toString();
                                  TextEditingController direccioncontroll=TextEditingController();
                                  direccioncontroll.text=direccion;
                                  await cl.dialogClientUpdate(context,size,dnicontroll,namecontroll,tlfcontroll,direccioncontroll,dni); //este ultimo dni q le paso es para identificar que registro actualizo
                                  setState(() {});

                                }),
                            IconButton(icon: const Icon(Icons.delete), onPressed: ()async {

                                  await cl.dialogClientDelete(context,dni); //este ultimo dni q le paso es para identificar que registro actualizo
                                  setState(() {});




                            }),
                          ],
                        ),
                      ))

                  );
              }).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

Widget CardList(Size size, String dni, String name, int tlf, String direccion) {
  return Card(
      elevation: 5,
      child: ListTile(
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
                      
                    }),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ],
            ),
          ))
          

      /*shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height/9,

              child: 
                  Row(
                    
                    
                    children: [
                      Column(children: [


                      ],),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [

                        Row(children: [
                        Padding(padding:EdgeInsets.only(left: 20) ,
                        child: Text(dni)),
                      ],),

                      Row(children: [
                        Padding(padding:EdgeInsets.only(left: 20) ,
                        child: Text(name)),
                      ],),

                      Row(children: [
                        Padding(padding:EdgeInsets.only(left: 20) ,
                        child: Text(tlf.toString())),
                      ],),

                      Row(children: [
                        Padding(padding:EdgeInsets.only(left: 20) ,
                        child: Text(direccion)),
                      ],),


                    ],),



                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        
                        
                        children: [
                        IconButton(
                              icon: const Icon(Icons.edit), onPressed: () {}),
                          IconButton(
                              icon: const Icon(Icons.delete), onPressed: () {}),

                      ],),
                  

                      

                ]),
                





            )
            
           
            
          ],
        ),
      )*/

      );
}
