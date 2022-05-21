import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/view/billsView.dart';
import 'package:tallermecanico/view/clients/clientsView.dart';

import 'package:tallermecanico/view/home.dart';
import 'package:tallermecanico/view/login/forgotPassword.dart';
import 'package:tallermecanico/view/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tallermecanico/view/login/loginSignUp.dart';
import 'package:tallermecanico/view/mechanic/mechanicsView.dart';
import 'package:tallermecanico/view/photos/vehiclephotosList.dart';
import 'package:tallermecanico/view/repairorders/addrepair_ordersView.dart';
import 'package:tallermecanico/view/repairorders/repair_ordersView.dart';
import 'package:tallermecanico/view/spareView.dart';
import 'package:tallermecanico/view/photos/vehiclephotosView.dart';
import 'package:tallermecanico/view/vehicle/vehiclesView.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //se inicializa FireBase de forma asincrona

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //establezco las rutas de las distintas pantallas para poder interactuar entre ellas
        'Login': (context) => Login(),
        'LoginSignUp': (context) => LoginSignUp(),
        'ForgotPassword': (context) => ForgotPassword(),
        'MechanicsView': (context) => MechanicsView(),
        //'f': (context) => M(),////////////
        'ClientsView': (context) => ClientsView(),
        'VehiclesView': (context) => VehiclesView(),
        'SpareView': (context) => SpareView(),
        'Repair_ordersView': (context) => Repair_ordersView(),
        'BillsView': (context) => BillsView(),
        'VehiclePhotosView': (context) => VehiclePhotosView(),
        'VehiclePhotosList': (context) => VehiclePhotosList(),
        'AddRepair_ordersView': (context) => AddRepair_ordersView(),
      },
      navigatorKey: navigatorKey,
      home: StreamBuilder<User?>(
        //el stream permite recibir un flujo de datos, es decir devuelve un snapshot, el cual permite ver el estado del usuario en todo momento
        stream: FirebaseAuth.instance
            .authStateChanges(), //cada vez que el estado del usuario cambia (usuario loggeado o no), devuelve un snapshot con esa información
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //si se está realizando la conexión
            return Center(
                child: CircularProgressIndicator()); //indicador de carga
          } else if (snapshot.hasError) {
            //si ocurre un error
            return Center(child: Text("Algo salió mal, intentalo más tarde"));
          } else if (snapshot.hasData) {
            //para comprobar la información que devuelve el stream y ver si el usuario está loggeado o no
            //si el usuario esta loggeado se dirige a la pantalla de Home, sino a la de Login
            return Home();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
