import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../alertdialog/dialogError.dart';

class VehicleUploadPhotos extends StatefulWidget {
  const VehicleUploadPhotos({Key? key}) : super(key: key);

  @override
  State<VehicleUploadPhotos> createState() => _ScreenState();
}

class _ScreenState extends State<VehicleUploadPhotos> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  DialogError dialog = DialogError();
  //PhotoController photo = PhotoController();
  bool hasInternet=false;

  @override
  void dispose() {
    super.dispose();
    pickedFile =
        null; //le doy valor null para que desaparezca la imagen en la vista
    uploadTask = null;
  }

  @override
  void initState(){
    super.initState();

    InternetConnectionChecker().onStatusChange.listen((status) { 
      final hasInternet=status==InternetConnectionStatus.connected;
      print('internet'+hasInternet.toString());

      setState(() {
        this.hasInternet=hasInternet;
      });

    });
  }

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
                if (pickedFile != null)
                  Expanded(
                      child: Container(
                          color: Colors.blue[100],
                          child: Center(
                            child: Image.file(
                              File(pickedFile!.path!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ))),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    selectPhoto();
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
                  onPressed: () {
                    uploadPhoto();
                  },
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
                ),
                const SizedBox(
                  height: 20,
                ),
                if (pickedFile != null) buildProgress()
              ],
            ))));
  }

  Future selectPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false, //que no pueda elegir varias fotos
      type: FileType.image, //solo imagenes como archivo permitido
    );
    if (result == null) return;

    setState(() {
      pickedFile = result
          .files.first; //se introduce dentro de pickedFile la imagen elegida
    });
  }

  Future uploadPhoto() async {
    try {
      if (pickedFile != null /*&& hasInternet==true*/ ) {
        final path =
            'fotos/${pickedFile!.name}'; //carpeta donde se subiran la imagen de firebase storage
        final file = File(pickedFile!.path!); //archivo

        final ref = FirebaseStorage.instance
            .ref()
            .child(path); //instancia de firebase storage para acceder a él
        setState(() {
          uploadTask = ref.putFile(file);
        });
        //uploadTask = ref.putFile(file); //se sube el archivo

        final snapshot = await uploadTask!.whenComplete(() {
          //String mensaje='Imagen subida';dialog.dialogError(context, mensaje);
        }); //cuando termine de subir la imagen avisa al usuario

        final urlDownload = await snapshot.ref
            .getDownloadURL(); //se obtiene la url de la imagen en firebase
        print('uuu ' + urlDownload);
        if (mounted) {
          setState(() {
            pickedFile =
                null; //le doy valor null para que desaparezca la imagen en la vista
            uploadTask = null;
          });
        }
      } else {
        String error = 'Seleccione una imagen antes de subirla';
        dialog.dialogError(context, error);
        print('ooooooooooooooo');
        //await uploadTask!.cancel();
      }
    } on FirebaseException catch (e) {
      String error ='Se ha perdido la conexión a internet, y no se ha podido subir la imagen, intentelo de nuevo';//si se empieza a subir la foto y se pierde el internet, si se mtiene el usuario en esta pantalla y vuelve el internet saltará este error
      
          print('iiiii');
      if (mounted) {//es para comprobar si esta pantalla aun se está mostrando, si el usuario no ha dado para atrás
      dialog.dialogError(context, error);
      }
    }
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      //metodo para ver el avance de la subida de la imagen
      stream: uploadTask
          ?.snapshotEvents, //recibe un flujo de datos respecto a la subida del archivo
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //si se reciben datos
          final data = snapshot.data!;
          double progress = data.bytesTransferred /
              data.totalBytes; //se obtiene el progreso dividiendo el numero de bytes subidos entre los totales

          return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text('${(100 * progress).roundToDouble()}%',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ));
        } else {
          return SizedBox(height: 50);
        }
      });
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