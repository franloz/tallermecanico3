import 'package:firebase_auth/firebase_auth.dart';

class HomeController {
  //final user = FirebaseAuth.instance.currentUser!; //usuario actual
  void cerrar(){
    FirebaseAuth.instance.signOut();
  }
}
