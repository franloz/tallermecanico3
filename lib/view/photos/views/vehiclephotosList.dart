import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/view/photos/views/vehiclephotosView.dart';

import '../dialogphotodelete.dart';

class VehiclePhotosList extends StatefulWidget {
  const VehiclePhotosList({Key? key}) : super(key: key);

  @override
  State<VehiclePhotosList> createState() => _ScreenState();
}

class _ScreenState extends State<VehiclePhotosList> {
  String search = '';
  TextEditingController searchtxt = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;//usuario actual
  DialogPhotoDelete dialogdelete = DialogPhotoDelete();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return  Scaffold(
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

                      search = searchtxt.text.toUpperCase();
                      setState(() {}); //para actualizar la vista
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
            FocusScope.of(context).unfocus(); //para que el textfield pierda el foco

            await Navigator.pushNamed(context,'VehicleUploadPhotos'); //con el await hacemos q espere a q se cierre el dialog para seguir ejecutando el codigo en este caso el setstate

            setState(() {});
          }),
      body: Row(children: [
        Container(
            height: size.height,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: loadList(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =document.data()! as Map<String, dynamic>;
                      String url = data['url'];
                      String matricula = data['matricula'];
                      String idfirebase = data['idfirebase'];
                      String nombreimagen = data['nombreimagen'];

                      return miCardImageCarga(url, size, matricula, context,dialogdelete, idfirebase, nombreimagen);
                    }).toList(),
                  );
                })),
      ]),
    );
  }

  Stream<QuerySnapshot> loadList() {
    if (search != '') {
      print(search.toUpperCase());
      return FirebaseFirestore.instance
          .collection('fotos')
          .where("userid", isEqualTo: user.uid)//este where es para que muestre los datos del usuario loggeado
          .where('matricula', isEqualTo: search)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('fotos')
          .where("userid", isEqualTo: user.uid)//este where es para que muestre los datos del usuario loggeado
          .snapshots(); 
    } 
  }
}

Widget miCardImageCarga(
    String url,
    Size size,
    String matricula,
    BuildContext context,
    DialogPhotoDelete dialogdelete,
    String idfirebase,
    String nombreimagen) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                    child: FittedBox(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    height: size.height / 2.5,
                    width: size.width,
                    placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black12,
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ))
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(matricula),
                        ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                  await dialogdelete.dialogPhotoDelete(context,idfirebase,nombreimagen); //metodo que borra en la base de datos
                                }),
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_circle_right),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
                                  await Navigator.pushNamed(context, 'VehiclePhotosView', arguments: {"url": url});
                                  //await Navigator.of(context).push(MaterialPageRoute(builder:(context)=>VehiclePhotosView()));
                                }),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
