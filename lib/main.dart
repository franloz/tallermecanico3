import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tallermecanico/view/bills/billsView.dart';
import 'package:tallermecanico/view/clients/clientinsertView.dart';
import 'package:tallermecanico/view/clients/clientsView.dart';
import 'package:tallermecanico/view/clients/clientupdateView.dart';

import 'package:tallermecanico/view/home.dart';
import 'package:tallermecanico/view/login/forgotPassword.dart';
import 'package:tallermecanico/view/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tallermecanico/view/login/loginSignUp.dart';
import 'package:tallermecanico/view/mechanic/mechanicinsertView.dart';
import 'package:tallermecanico/view/mechanic/mechanicsView.dart';
import 'package:tallermecanico/view/mechanic/mechanicupdateView.dart';
import 'package:tallermecanico/view/photos/vehiclephotosList.dart';
import 'package:tallermecanico/view/repairlines/repairLinesView.dart';
import 'package:tallermecanico/view/repairlines/repairlinessinsertView.dart';
import 'package:tallermecanico/view/repairlines/repairlinesupdateView.dart';
import 'package:tallermecanico/view/repairorders/repairordersView.dart';
import 'package:tallermecanico/view/repairorders/repairordersinsertView.dart';
import 'package:tallermecanico/view/repairorders/repairordersupdateView.dart';
import 'package:tallermecanico/view/spare/spareView.dart';
import 'package:tallermecanico/view/photos/vehiclephotosView.dart';
import 'package:tallermecanico/view/spare/spareinsertView.dart';
import 'package:tallermecanico/view/spare/spareupdateView.dart';
import 'package:tallermecanico/view/vehicle/vehicleinsertView.dart';
import 'package:tallermecanico/view/vehicle/vehiclesView.dart';
import 'package:tallermecanico/view/vehicle/vehicleupdateView.dart';

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
        'RepairordersView': (context) => RepairOrdersView(),
        'RepairLinesView': (context) => RepairLinesView(),
        'BillsView': (context) => BillsView(),
        'VehiclePhotosView': (context) => VehiclePhotosView(),
        'VehiclePhotosList': (context) => VehiclePhotosList(),
        'ClientInsertView': (context) => ClientInsertView(),
        'ClientUpdateView': (context) => ClientUpdateView(),
        'MechanicUpdateView': (context) => MechanicUpdateView(),
        'MechanicInsertView': (context) => MechanicInsertView(),
        'VehicleUpdateView': (context) => VehicleUpdateView(),
        'VehicleInsertView': (context) => VehicleInsertView(),
        'SpareUpdateView': (context) => SpareUpdateView(),
        'SpareInsertView': (context) => SpareInsertView(),
        'RepairOrdersUpdateView': (context) => RepairOrdersUpdateView(),
        'RepairOrdersInsertView': (context) => RepairOrdersInsertView(),
        'RepairLinesUpdateView': (context) => RepairLinesUpdateView(),
        'RepairLinesInsertView': (context) => RepairLinesInsertView(),




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
