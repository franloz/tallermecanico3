import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/spare.dart';
import 'package:tallermecanico/view/spare/dialogSpareDelete.dart';

class SpareView extends StatefulWidget {
  const SpareView({Key? key}) : super(key: key);

  @override
  State<SpareView> createState() => _ScreenState();
}

class _ScreenState extends State<SpareView> {
  DialogSpareDelete dialog = DialogSpareDelete();
  DatabaseSqlite dt = DatabaseSqlite();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

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
                      FocusScope.of(context)
                          .unfocus(); //para que el textfield pierda el foco
                      search = searchtxt.text;
                      setState(() {});
                    },
                  ),
                  hintText: 'Pieza a buscar',
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
            //await cl.dialogSpareInsert(context,size); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
            await  Navigator.pushNamed(context, 'SpareInsertView');
            setState(() {});
          }),
      body: FutureBuilder<List<Spare>>(
          future: loadList(), ////un metodo que controle si hay busqueda o no
          builder:
              (BuildContext context, AsyncSnapshot<List<Spare>> snapshot) {
            if (snapshot.hasError) {
              return Text('Ha ocurrido un error');
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((spare) {

                String id=spare.id;
                String marca=spare.marca;
                String pieza=spare.pieza;
                String precio=spare.precio;
                int stock=spare.stock;
                int telfproveedor=spare.telfproveedor;

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(id, marca, pieza, precio,stock,telfproveedor);

                         
                        },
                        leading: Icon(Icons.miscellaneous_services_sharp),
                        title: Text(marca),
                        subtitle: Text(pieza),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                    //le asigno a los controladores del alertdialog los valores del usuario a modificar para que aparezcan escriyos en los textFields del dialog
                                    //TextEditingController idcontroll =TextEditingController();
                                    //TextEditingController marcacontroll =TextEditingController();
                                    //TextEditingController piezacontroll =TextEditingController();
                                    TextEditingController preciocontroll =TextEditingController();
                                    TextEditingController stockcontroll =TextEditingController();
                                    TextEditingController telfproveedorcontroll =TextEditingController();
                                    //idcontroll.text = id;
                                    //marcacontroll.text = marca;
                                    //piezacontroll.text = pieza;
                                    preciocontroll.text = precio;
                                    stockcontroll.text = stock.toString();
                                    telfproveedorcontroll.text = telfproveedor.toString();

                                    await Navigator.pushNamed(context, 'SpareUpdateView',arguments: {
                                          "marca": marca,
                                          "pieza":pieza,
                                          "preciocontroll":preciocontroll,
                                          "stockcontroll":stockcontroll,
                                          "telfproveedorcontroll":telfproveedorcontroll,
                                          "id":id,
                                          
                                          
                                          });

                                    //await cl.dialogSpareUpdate(context,size,marca,pieza,preciocontroll,stockcontroll,telfproveedorcontroll,id); //este ultimo dni q le paso es para identificar que registro actualizo
                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco
                                    await dialog.dialogSpareDelete(context, id);
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

  Future<List<Spare>> loadList() async {
    if (search != '') {
      return dt.getSpareWhere(search);
    } else {
      return dt.getSpares();
    }
  }

  void bottomSheet(String id,String marca,String pieza,String precio,int stock,int telfproveedor) {
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
            title: Text('Id'),
            subtitle: Text(id),
          ),
          ListTile(
            title: Text('Marca'),
            subtitle: Text(marca),
          ),
          ListTile(
            title: Text('Pieza'),
            subtitle: Text(pieza),
          ),
          ListTile(
            title: Text('Precio'),
            subtitle: Text(precio.toString()),
          ),
          ListTile(
            title: Text('Stock'),
            subtitle: Text(stock.toString()),
          ),
          ListTile(
            title: Text('Telfproveedor'),
            subtitle: Text(telfproveedor.toString()),
          ),
        ],
      ),
    );
  }
}

/*class SpareView extends StatelessWidget {
  const SpareView({Key? key}) : super(key: key);

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
  DialogSpare dialog = DialogSpare();

  TextEditingController searchtxt = TextEditingController();

  String search = '';

  /*@override
  void initState(){
      
  }*/

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
                    hintText: 'Pieza a buscar en minúscula',
                  ),
                ),
              ),
            )),
        backgroundColor: Colors.grey[800],
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 229, 255),
            child: Icon(Icons.add),
            onPressed: () {
              FocusScope.of(context)
                  .unfocus(); //para que el textfield pierda el foco
              dialog.dialogSpareInsert(context,
                  size); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
              //setState(() {});
            }),
        body: StreamBuilder<QuerySnapshot>(
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
                String id = data['id'];
                String marca = data['marca'];
                String pieza = data['pieza'];
                double precio = data['precio'];
                int stock = data['stock'];
                int telfproveedor = data['telfproveedor'];
                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(
                              id, marca, pieza, precio, stock, telfproveedor);
                        },
                        leading: Icon(Icons.miscellaneous_services_sharp),
                        title: Text(data['marca']),
                        subtitle: Text(data['pieza']),
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

                                    TextEditingController marcacontroll =
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
                                        id); //este ultimo dni q le paso es para identificar que registro actualizo
                                    //setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco
                                    print(id);
                                    await dialog.dialogSpareDelete(context, id);
                                    //setState(() {});
                                  }),
                            ],
                          ),
                        )));
              }).toList(),
            );
          },
        ));
  }

  void bottomSheet(String id, String marca, String pieza, double precio,
      int stock, int telfproveedor) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        children: [
          ListTile(
            title: Text('Id'),
            subtitle: Text(id),
          ),
          ListTile(
            title: Text('Marca'),
            subtitle: Text(marca),
          ),
          ListTile(
            title: Text('Pieza'),
            subtitle: Text(pieza),
          ),
          ListTile(
            title: Text('Precio'),
            subtitle: Text(precio.toString()),
          ),
          ListTile(
            title: Text('Stock'),
            subtitle: Text(stock.toString()),
          ),
          ListTile(
            title: Text('Teléfono proveedor'),
            subtitle: Text(telfproveedor.toString()),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> loadList() {
    if (search != '') {
      print(search.toUpperCase());
      return FirebaseFirestore.instance
          .collection('spare')
          .where('pieza', isEqualTo: search)
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('spare').snapshots();
    }
  }
}
/*ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['marca']),
                  subtitle: Text(data['pieza']),
                );
              }).toList(),
            );*/ */