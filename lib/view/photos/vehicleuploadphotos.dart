import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../controller/photocontroller.dart';

class VehicleUploadPhotos extends StatefulWidget {
  const VehicleUploadPhotos({Key? key}) : super(key: key);

  @override
  State<VehicleUploadPhotos> createState() => _ScreenState();
}

class _ScreenState extends State<VehicleUploadPhotos> {
  PlatformFile? pickedFile;
  PhotoController photo = PhotoController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Fotos"),
              backgroundColor: Color.fromARGB(255, 0, 229, 255),
            ),
            backgroundColor: Colors.grey[800],
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    photo.selectFile();
                  },
                  child: Text(
                    'Seleccionar foto',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height / 63),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        size.width / 3,
                        size.height /
                            8), //ancho y alto del boton en relación a la pantalla
                    primary: Color.fromARGB(255, 0, 145, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Subir foto',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height / 50),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        size.width / 3,
                        size.height /
                            8), //ancho y alto del boton en relación a la pantalla
                    primary: Color.fromARGB(255, 0, 145, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                )
              ],
            ))));
  }

  Future selectFile() async {
    final result = await FilePickerWeb.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }
}


/* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.upload,
                                size: size.height / 15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Subir",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 34),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "fotos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height / 34),
                              ),
                            ],
                          )
                        ],
                      ),

                      onPressed: () {
                       // Navigator.pushNamed(context, 'Repair_ordersView');
                      }, //se lanza la actividad de Ördenes de reparación
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            size.width / 2.3,
                            size.height /
                                6.7), //ancho y alto del boton en relación a la pantalla
                        primary: Color.fromARGB(255, 0, 145, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ), //para separar rows*/