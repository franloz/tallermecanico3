import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/clients/dialogClients.dart';

import '../../model/client.dart';

class ClientsView extends StatelessWidget {
  DialogClients cl = DialogClients();
  //DatabaseSqlite dt = DatabaseSqlite();
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
                  cl.dialogClient(context);
                }),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: dt.getClients(),
                    builder: (BuildContext context, AsyncSnapshot<List<Client>>snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.hasError.toString());
                      }
                      if (snapshot.hasData) {
                        return ListView(
                          children:<Widget>[
                            for(Client client in snapshot.data!) ListTile(title: Text(client.dni),)


                            



                          ],
                      
                        );


                      } else {
                        return Column(


                        );
                      }
                    }),
              ],
            )));
  }
}
