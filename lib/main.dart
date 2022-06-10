import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tallermecanico/view/bills/views/billinsertView.dart';
import 'package:tallermecanico/view/bills/views/billsView.dart';
import 'package:tallermecanico/view/clients/views/clientinsertView.dart';
import 'package:tallermecanico/view/clients/views/clientsView.dart';
import 'package:tallermecanico/view/clients/views/clientupdateView.dart';
import 'package:tallermecanico/view/home.dart';
import 'package:tallermecanico/view/login/views/forgotPassword.dart';
import 'package:tallermecanico/view/login/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tallermecanico/view/login/views/loginSignUp.dart';
import 'package:tallermecanico/view/mechanic/views/mechanicinsertView.dart';
import 'package:tallermecanico/view/mechanic/views/mechanicsView.dart';
import 'package:tallermecanico/view/mechanic/views/mechanicupdateView.dart';
import 'package:tallermecanico/view/photos/views/vehiclephotosList.dart';
import 'package:tallermecanico/view/photos/views/vehiclephotosView.dart';
import 'package:tallermecanico/view/photos/views/vehicleuploadphotos.dart';
import 'package:tallermecanico/view/repairlines/views/repairLinesView.dart';
import 'package:tallermecanico/view/repairlines/views/repairlinessinsertView.dart';
import 'package:tallermecanico/view/repairlines/views/repairlinesupdateView.dart';
import 'package:tallermecanico/view/repairorders/views/repairordersView.dart';
import 'package:tallermecanico/view/repairorders/views/repairordersinsertView.dart';
import 'package:tallermecanico/view/repairorders/views/repairordersupdateView.dart';
import 'package:tallermecanico/view/spare/views/spareView.dart';
import 'package:tallermecanico/view/spare/views/spareinsertView.dart';
import 'package:tallermecanico/view/spare/views/spareupdateView.dart';
import 'package:tallermecanico/view/vehicle/views/vehicleinsertView.dart';
import 'package:tallermecanico/view/vehicle/views/vehiclesView.dart';
import 'package:tallermecanico/view/vehicle/views/vehicleupdateView.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //se inicializa FireBase de forma asincrona

  WidgetsFlutterBinding.ensureInitialized();//para que no permita poner la app en horizontal
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
        'BillInsertView': (context) => BillInsertView(),
        'VehicleUploadPhotos': (context) => VehicleUploadPhotos(),





      },
      navigatorKey: navigatorKey,
      home: StreamBuilder<User?>(
        //el stream permite recibir un flujo de datos, es decir devuelve un snapshot, el cual permite ver el estado del usuario en todo momento
        stream: FirebaseAuth.instance.authStateChanges(), //cada vez que el estado del usuario cambia (usuario loggeado o no), devuelve un snapshot con esa información
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
