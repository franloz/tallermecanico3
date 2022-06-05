import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VehiclePhotosView extends StatefulWidget {
  const VehiclePhotosView({Key? key}) : super(key: key);

  @override
  State<VehiclePhotosView> createState() => _ScreenState();
}

class _ScreenState extends State<VehiclePhotosView> {
  @override
  Widget build(BuildContext context) {
    Map? parametros = ModalRoute.of(context)?.settings.arguments as Map?; //para coger el argumento q se pasa desde la otra pantalla
    String url = parametros!["url"];
    final size = MediaQuery.of(context).size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return  Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Fotos"),
              backgroundColor: Color.fromARGB(255, 0, 229, 255),
            ),
            backgroundColor: Colors.grey[800],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                      child: Container(
                          color: Colors.blue[100],
                          child: Center(
                            child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black12,
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  ))),
              ],
            ));
  }
}
