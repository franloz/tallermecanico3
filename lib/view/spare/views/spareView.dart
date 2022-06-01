
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tallermecanico/model/spare.dart';
import 'package:tallermecanico/view/spare/dialogSpareDelete.dart';

import '../../../controller/sparecontroller.dart';

class SpareView extends StatefulWidget {
  const SpareView({Key? key}) : super(key: key);

  @override
  State<SpareView> createState() => _ScreenState();
}

class _ScreenState extends State<SpareView> {
  DialogSpareDelete dialog = DialogSpareDelete();
  //DatabaseSqlite dt = DatabaseSqlite();
  SpareController cr=SpareController();

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
                          FocusScope.of(context) .unfocus(); //para que el textfield pierda el foco

                          bottomSheet(id, marca, pieza, precio,stock,telfproveedor,size);

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
                                   
                                    TextEditingController preciocontroll =TextEditingController();
                                    TextEditingController stockcontroll =TextEditingController();
                                    TextEditingController telfproveedorcontroll =TextEditingController();
                                    
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

                                    setState(() {});
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    FocusScope.of(context) .unfocus(); //para que el textfield pierda el foco
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
      return cr.getSpareWhere(search);
    } else {
      return cr.getSpares();
    }
  }

  void bottomSheet(String id,String marca,String pieza,String precio,int stock,int telfproveedor, Size size) {
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
                    await FlutterPhoneDirectCaller.callNumber(telfproveedor.toString());
                    
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

