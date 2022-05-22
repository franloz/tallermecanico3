import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/vehicle/dialogVehicles.dart';

import '../../model/Vehicle.dart';

class VehiclesView extends StatelessWidget {
  const VehiclesView({Key? key}) : super(key: key);

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
  DialogVehicles cl = DialogVehicles();
  DatabaseSqlite dt = DatabaseSqlite();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

  List<String> lista = [];
  @override
  void initState() {
    //en este init obtengo los dni de los clientes y los introduzco en una lista para poder mostrarlos en el dropdownmenuitem (combobox) de la pantalla DialogVehicle
    dt.getClientsdni().then((listMap) {
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
            await cl.dialogVehicleInsert(context, size,
                lista); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
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
                String clientedni = mechanic.clientedni;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(matricula,marca,modelo,clientedni);
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
                                    TextEditingController dnicontroll =
                                        TextEditingController();
                                    dnicontroll.text = matricula;
                                    TextEditingController namecontroll =
                                        TextEditingController();
                                    namecontroll.text = marca;
                                    TextEditingController tlfcontroll =
                                        TextEditingController();
                                    tlfcontroll.text = modelo;
                                    TextEditingController direccioncontroll =
                                        TextEditingController();
                                    direccioncontroll.text = clientedni;
                                    await cl.dialogVehicleUpdate(
                                        context,
                                        size,
                                        dnicontroll,
                                        namecontroll,
                                        tlfcontroll,
                                        direccioncontroll,
                                        matricula,
                                        lista); //este ultimo dni q le paso es para identificar que registro actualizo
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

  void bottomSheet(String matricula, String marca, String modelo, String clientedni) {
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
}


/*TextEditingController nombre =
      TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController apellidos = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController preciohora = TextEditingController();

  String nom = "";
  String ape = "";
  double preci = 0;
  String direcci = "";


  //final FocusNode _commentFocus = FocusNode();

  MechanicsViewController cr =
      MechanicsViewController(); //me creo una variable de la clase HomeController para usar los métodos que hay en ella y sus variables

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            child: Center(
              child: TextField(
                onChanged:(text){nom = nombre.text;},//si le da a intro del teclado re refresca el widget con las busquedas
                controller: nombre,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      
                      nom = nombre.text;//se coge la matricula introducida y se usa para filtrar
                      //setState(text) {};
                      //FocusManager.instance.primaryFocus
                          //?.unfocus(); //para esconder teclado, y refresca widget

                      FocusScope.of(context).unfocus();//se elimina el foco del contexto actual y se refrescan los widget mostrando la busqueda

                      
                      //filtro='jj';
                      
                      
                      
                    },
                  ),
                  hintText: 'Matrícula del coche a buscar',
                ),
              ),
            ),
          )),
      backgroundColor: Colors.grey[800],
      
      body: Row(children: [
        Container(
            height: size.height,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('fotos')
                    .where('matricula', isEqualTo: nom)
                    .snapshots(),
                //FirebaseFirestore.instance.collection('fotos').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.hasError.toString());
                  }

                  ///poner en otro sitio

                  if (snapshot.hasData) {
                    final mecha = snapshot.data!;
                    //mecha.size.toString() tamaño de la lista, cuantos documentos ahi

                    /*return ListView.builder(
                          itemCount: tamano,
                          itemBuilder: (context, index) {

                              DocumentSnapshot documentSnapshot AsyncSnapshot<dynamic> snapshot snapshot.data.documents[index];
                            return Row(
                              children: [
                                Image.network(
                                  data['url'],
                                  height: 200,
                                  width: 200,
                                ),
                              ],
                            );
                          });*/

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        //String matricula = data['matricula'];
                        String url = data['url'];

                        return miCardImageCarga(url,
                            size); /*SizedBox(
                            height: 200,
                            child: ListTile(
                              onTap: () {
                                String v = data['url'];
                                print(
                                    v); //buscar lo escrito entre % y ?///////////////////////// o añadir otro campo a tabala
                              },
                              //horizontalTitleGap: 0.0,
                              leading: SizedBox(
                                height: 500.0,
                                width: 200.0, // fixed width and height
                                child: Stack(
                                  children: <Widget>[
                                    const Center(
                                        child: CircularProgressIndicator()),
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            data['url'],
                                            height: 700,
                                            width: 500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              dense: true,
                              visualDensity: VisualDensity(
                                  vertical: 4, horizontal: 4), // to expand
                              //onTap: ,
                            ));*/
                      }).toList(),
                    );
                  } else {
                    return Column(
                        /*mainAxisAlignment: MainAxisAlignment
            .center,
                      //child: CircularProgressIndicator(),
                      children:[Text(
                          "Aquí se mostrarán las imágenes del vehículo",
                          style: TextStyle(
                              color: Colors.white, fontSize: size.height / 34),
                        )]*/
                        );
                  }
                })),
      ]),
    ));
  }
}

Widget buildMeca(Mechanic me) => ListTile(
      leading: CircleAvatar(child: Text('${me.apellidos}')),
      title: Text(me.nombre),
      subtitle: Text('jb'),
    );

/*Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }*/

Widget miCardImageCarga(String url, Size size) {
  return Card(
        /*semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            url,
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),*/
        








      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: <Widget>[
            /*Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
                FittedBox(
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: 300,
                    width: size.width,
                  ),
                )
              ],
            ),*/
 Stack(
              children: <Widget>[
                SizedBox(
                  height: size.height / 2.8,
                  width: size.width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Center(child: FittedBox(
                  
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: size.height/2.5,
                    width: size.width,
                  ),
                ))
              ],
            ), 

            Container(
              padding: EdgeInsets.all(10),
              child: Text('Paisaje con carga'),
            )
          ],
        ),
      )
      /*child: Column(
    children: [
      Row(
        children: [
          Stack(
            children: <Widget>[
              const Center(child: CircularProgressIndicator()),
              Center(
                child: Image.network(
                  url,
                  height: 300,
                  width: size.width,
                ),
              )
            ],
          ),
        ],
      ),
      Row(
        children: [Text('kjkifkf')],
      )
    ],
  )*/
      );*/