import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VehiclesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late Future<List<FirebaseFile>> futureFiles = FirebaseApi.listAll('files/');

    final size = MediaQuery.of(context)
        .size; //saca el tamaño de la pantalla para poder hacer la app responsive
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Vehículos"),
              backgroundColor: Color.fromARGB(255, 0, 229, 255),
            ),
            backgroundColor: Colors.grey[800],
            floatingActionButton: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 0, 229, 255),
                child: Icon(Icons.add),
                onPressed: () async {
                  /*final storageRef = FirebaseStorage.instance.ref();
                  String imagesRef = await storageRef
                      .child("files/kkkkk.png")
                      .getDownloadURL();

                  print(imagesRef);*/
                  final storageRef = FirebaseStorage.instance.ref('files/');

                  final listResult = await storageRef.listAll();
                  for (var prefix in listResult.items) {
                    print(prefix.getDownloadURL());
                  }

                  print('FloatingActionButton');
                }),
            body: FutureBuilder<List<FirebaseFile>>(
                future: futureFiles,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(child: Text('error'));
                      } else {
                        final files = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: files.length,
                                    itemBuilder: (context, index) {
                                      final file = files[index];

                                      return Image.network(file.url);
                                    }))
                          ],
                        );
                      }
                  }
                })));
  }
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}

class FirebaseApi {
  static Future<List<String>> downloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await downloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}
