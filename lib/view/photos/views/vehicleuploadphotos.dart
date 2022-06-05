import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../alertdialog/dialogError.dart';
import '../../../controller/photocontroller.dart';

class VehicleUploadPhotos extends StatefulWidget {
  const VehicleUploadPhotos({Key? key}) : super(key: key);

  @override
  State<VehicleUploadPhotos> createState() => _ScreenState();
}

class _ScreenState extends State<VehicleUploadPhotos> {
  PlatformFile? pickedFile;//para el archivo
  UploadTask? uploadTask;//para subirlo a firebase
  DialogError dialog = DialogError();
  PhotoController photo = PhotoController();
  TextEditingController matriculatxt = TextEditingController();

  @override
  void dispose() async {
    //para que no de problemas si pierde la conexion a internet y se sale de esta pantalla
    super.dispose();
    pickedFile = null;
    uploadTask = null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //saca el tamaño de la pantalla para poder hacer la app responsive
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
                  height: 10,
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
                  height: 10,
                ),

                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus(); //para que el textfield pierda el foco
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
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  children: [
                    Container(
                      width: size.width /1.1, //ancho del TextField en relación al ancho de la pantalla
                      height: size.height / 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                        color: Colors.grey[700],
                      ),
                      child: TextField(
                          controller: matriculatxt, //se identifica el controlador del TextField
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 0, 229, 255)),
                              ),
                              prefixIcon: Icon(Icons.circle_outlined),
                              border: InputBorder.none,
                              hintText: "Introduzca matrícula",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),

                if (pickedFile != null) buildProgress(),
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
      pickedFile = result.files.first; //se introduce dentro de pickedFile la imagen elegida
    });
  }

  Future uploadPhoto() async {
    try {
      if (pickedFile != null && matriculatxt.text.isNotEmpty ) {
        final path ='fotos/${pickedFile!.name}'; //carpeta donde se subiran la imagen de firebase storage
        final file = File(pickedFile!.path!); //archivo

        final ref = FirebaseStorage.instance.ref().child(path); //instancia de firebase storage para acceder a él
        setState(() {
          uploadTask = ref.putFile(file); //se sube el archivo
        });

        final snapshot = await uploadTask!.whenComplete(() {}); //cuando termine de subir la imagen

        final urlDownload = await snapshot.ref.getDownloadURL(); //se obtiene la url de la imagen en firebase
        print('uuu ' + urlDownload);

        String nombreimagen = pickedFile!.name; //nombre de la imagen para luego borrarla de storage
        String matricula =matriculatxt.text.toUpperCase(); //matricula del coche para identificar las fotos
        photo.insert(urlDownload, matricula, nombreimagen,context);//metodo para insertar en la base de datos

        if (mounted) {
          //si esta pantalla aun se encuentra mostrandose. Esto se usa para que la apicacion no falle si se pierde la conexion a internet y el usuario se sale de esta actividad
          setState(() {
            pickedFile =null; //le doy valor null para que desaparezca la imagen en la vista
            uploadTask = null;
            matriculatxt.clear();
          });
        }
      } else {
        String error ='Seleccione una imagen antes de subirla, o introduce una matrícula';
        dialog.dialogError(context, error);
        
      }
    } on FirebaseException catch (e) {
      String error ='Se ha perdido la conexión a internet, y no se ha podido subir la imagen, intentelo de nuevo'; //si se empieza a subir la foto y se pierde el internet, si se mantiene el usuario en esta pantalla y vuelve el internet saltará este error, dependiendo del tiempo que haya tardado en volver el internet
      if (mounted) {
        //es para comprobar si esta pantalla aun se está mostrando, si el usuario no ha dado para atrás
        dialog.dialogError(context, error);
      }
    }
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      //metodo para ver el avance de la subida de la imagen
      stream: uploadTask?.snapshotEvents, //recibe un flujo de datos respecto a la subida del archivo
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //si se reciben datos
          final data = snapshot.data!;
          double progress = data.bytesTransferred /data.totalBytes; //se obtiene el progreso dividiendo el numero de bytes subidos entre los totales

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
