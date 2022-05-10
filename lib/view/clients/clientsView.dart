import 'package:flutter/material.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/view/clients/dialogClients.dart';

import '../../model/client.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación',
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
  DialogClients cl = DialogClients();
  DatabaseSqlite dt = DatabaseSqlite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      backgroundColor: Colors.grey[800],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 229, 255),
          child: Icon(Icons.add),
          onPressed: () {
            cl.dialogClient(context);

            ///o inserto aqui con un setstate o refresco y pongo aqui los metodos de insert
            ///
/////meter dialog aqui y metodos de add y refrescar
            print('fnfhnfh');
            //setState(() {});
          }),
      body: FutureBuilder<List<Client>>(
          future: dt.getClients(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.map((client) {
                return ListTile(
                  title: Text(client.dni),
                  tileColor: Colors.white,
                  onLongPress: () {},
                  trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {}
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {}
                          ),
                        ],
                      ),
                      
                ));

              }).toList());
            } else {
              return Column(children: [Text('no hay datos')]);
            }
          }),
    );
  }
}
