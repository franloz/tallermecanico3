import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/bills/dialogBills.dart';

class BillsView extends StatefulWidget {
  const BillsView({Key? key}) : super(key: key);

  @override
  State<BillsView> createState() => _ScreenState();
}

class _ScreenState extends State<BillsView> {

  DialogBills dialog = DialogBills();



  List<String> listaordenes = [];
  DatabaseSqlite dt = DatabaseSqlite();
  @override
  void initState() {
    //en este init obtengo los id de las ordenes y los introduzco en una lista para poder mostrarlos en el dropdownmenuitem (combobox) de la pantalla DialogBills
    //se convierte una lista de map en una lista de string
    dt.getOrdenesId().then((listMap) {
      listMap.map((map) {
        print('fggfg');
        print(map.toString());

        return map['id'];
      }).forEach((dropDownItem) {
        listaordenes.add(dropDownItem);
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
            title: Text('Facturas')),
        backgroundColor: Colors.grey[800],
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 229, 255),
            child: Icon(Icons.add),
            onPressed: () async{
              FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
              await dialog.dialogBillsInsert(context, size, listaordenes); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate
              setState(() {});
            }),
        
        body: StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance.collection('facturas').snapshots(),
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
                String id=data['id'];
                String idorden = data['idorden'];
                String baseimponible = data['baseimponible'];
                String descuento = data['descuento'];
                String iva = data['iva'];
                String totalfactura = data['totalfactura'];
                

                return Card(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(
                              idorden,
                              baseimponible,
                              descuento,
                              iva,
                              totalfactura,
                             );
                        },
                        leading: Icon(Icons.euro),
                        title: Text(idorden),
                        subtitle: Text('Total: '+totalfactura),
                        trailing: SizedBox(
                          width: size.width / 4,
                          child: Row(
                            children: [
                              
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .unfocus(); //para que el textfield pierda el foco
                                    await dialog.dialogBillsDelete(context, id,idorden);
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

  void bottomSheet(
      String idorden,
                              String baseimponible,
                              String descuento,
                              String iva,
                              String totalfactura,) {
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
            title: Text('Base imponible'),
            subtitle: Text(baseimponible),
          ),
          ListTile(
            title: Text('Descuento'),
            subtitle: Text(descuento),
          ),
          ListTile(
            title: Text('Iva'),
            subtitle: Text(iva),
          ),
          ListTile(
            title: Text('Total factura'),
            subtitle: Text(totalfactura),
          ),
          
        ],
      ),
    );
  }


  

}
