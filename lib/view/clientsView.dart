import 'package:flutter/material.dart';

class ClientsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Clientes"),
              backgroundColor: Color.fromARGB(255, 0, 229, 255),
            ),
            backgroundColor: Colors.grey[800],
            floatingActionButton: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 0, 229, 255),
                child: Icon(Icons.add),
                onPressed: () {
                  print('FloatingActionButton');
                }),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            )));
  }
}
