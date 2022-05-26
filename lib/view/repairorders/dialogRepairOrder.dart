/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/firebasedatabase.dart';
import 'package:tallermecanico/model/repairorder.dart';

class DialogRepairOrder {
  TextEditingController numeroordentxt = TextEditingController();
  TextEditingController vehiculotxt = TextEditingController();
  TextEditingController mecanicotxt =TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController horasdedicadastxt = TextEditingController();
  TextEditingController descripcionreparaciontxt = TextEditingController();
  TextEditingController fechainiciotxt = TextEditingController();
  TextEditingController fechafintxt = TextEditingController();

  FirebaseDatabase base = FirebaseDatabase();

  String inicio='Inicio';
  String fin='Fin';
  var datestart;//la hago global para enviarla al calendario de fin para q no pueda poner dias anteriores a la fecha de inicio
  var dateend;



  String? dnimeca;//para el combobox
  String dnimecanico='';
  String? matriculavehi;//para el combobox
  String matriculavehiculo='';


  Future dialogRepairOrdersInsert(BuildContext context, Size size, List<String> listamecanicos, List<String> listavehiculos) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>StatefulBuilder(builder: ((context, setState) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Añadir Orden', style: TextStyle(color: Colors.white)),
            //content: Text(error),
            actions: <Widget>[
              Container(
                  width: size.width / 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Row(
                        //fila con un container y un TextField para contraseña
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [Container(
                          
                          width: size.width /1.4,
                          child: DropdownButton<String>(
                            
                            
                            hint:Text('Elige mecánico'),
                            isExpanded: true,
                            
                            items: listamecanicos.map(getdropdown).toList(),onChanged:( string) => setState(() {
                              
                              dnimecanico = string!;//esta variable cliente será la q se use para insertar los datos en sqlite,
                              //debido a que esta variable debe ser String para que se pueda insertar
                              
                              
                              dnimeca=string;} ),//esta variable se usa para que el DropdownButton detecte el valor pulsado ya que está variable debe ser
                              //String? la ? significa que esta variable puede ser nula, es decir que no requiere ser inicializada
                            
                            
                            value:dnimeca,
                            ), )
                                    //se convierte la lista de String a DropdownMenuItem<String>
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ), //para separar rows

                      
                      Row(
                        //fila con un container y un TextField para contraseña
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [Container(
                          
                          width: size.width /1.4,
                          child: DropdownButton<String>(
                            
                            
                            hint:Text('Elige vehículo'),
                            isExpanded: true,
                            
                            items: listavehiculos.map(getdropdown).toList(),onChanged:( string) => setState(() {
                              
                              matriculavehiculo = string!;//esta variable cliente será la q se use para insertar los datos en sqlite,
                              //debido a que esta variable debe ser String para que se pueda insertar
                              
                              
                              matriculavehi=string;} ),//esta variable se usa para que el DropdownButton detecte el valor pulsado ya que está variable debe ser
                              //String? la ? significa que esta variable puede ser nula, es decir que no requiere ser inicializada
                            
                            
                            value:matriculavehi,
                            ), )
                                    //se convierte la lista de String a DropdownMenuItem<String>
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ), //para separar rows

                      

                      Row(
                        //fila con un container y un TextField para contraseña
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /1.4, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),], //para que solo se pueda poner un punto
                                controller:horasdedicadastxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(width: 1,color:Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Horas dedicadas",
                                    hintStyle: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ), //para separar rows

                      Row(
                        //fila con un container y un TextField para contraseña
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width: size.width /
                                1.4, //ancho del TextField en relación al ancho de la pantalla
                            height: size.height / 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)), //bordes circulares
                              color: Colors.grey[700],
                            ),
                            child: TextField(
                                controller:descripcionreparaciontxt, //se identifica el controlador del TextField
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromARGB(255, 0, 229, 255)),
                                    ),
                                    prefixIcon: Icon(Icons.circle_outlined),
                                    border: InputBorder.none,
                                    hintText: "Descripción de la reparación",
                                    hintStyle: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ),



                      Row(
                        //fila con un container y un TextField para contraseña
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        children: [
                          Container(
                            width:size.width / 3 ,
                            child:
                            ElevatedButton.icon(
                              onPressed: ()async{
                                datestart =await pickDateStart(context);
                                setState(() {
                                    inicio=DateFormat('dd-MM-yyyy').format(datestart!);

                                });
                                
                              }, 
                              icon: Icon(Icons.calendar_today),
                              label: Text(inicio,style: TextStyle(fontSize: size.height / 65, color: Colors.white),),
                            ),
                          ),
                             SizedBox(
                            width:size.width / 13 ,
                            ),
                          Container(
                            width:size.width / 3 ,
                            child:
                            ElevatedButton.icon(
                              onPressed: ()async{
                                dateend =await pickDateEnd(context,datestart);
                                setState(() {
                                    fin=DateFormat('dd-MM-yyyy').format(dateend!);
                                });
                              }, 
                              icon: Icon(Icons.calendar_today),
                              label: Text(fin,style: TextStyle(fontSize: size.height / 65, color: Colors.white),),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ), //para separar rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        children: [
                          TextButton(
                            onPressed: () {
                              if ( matriculavehiculo=='Elige mecánico'||dnimecanico=='Elige vehículo'||datestart==null) {
                                String error ='Debe elegir al mecánico, el vehículo y la fecha de inicio';
                                DialogError dialogError = DialogError();
                                dialogError.dialogError(context, error);
                              } else {
                                

                                var order = RepairOrder(
                                  vehiculo: matriculavehiculo,
                                  mecanico: dnimecanico,
                                  horasdedicadas: horasdedicadastxt.text,
                                  descripcionreparacion: descripcionreparaciontxt.text,
                                  fechainicio: inicio,
                                  fechafin: fin,
                                );
//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

                                base.insertOrder(context, order);

                                horasdedicadastxt.clear();
                                descripcionreparaciontxt.clear();
                                matriculavehi='Elige vehículo';//restauro los combobox
                                dnimeca='Elige mecánico';
                                //inicio='Inicio';//restauro los botones de fechas
                               // fin='Fin';

                                

                                Navigator.of(context).pop();
                              }
                            }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                            child: Text('Guardar',style: TextStyle(fontSize: size.height / 35,color: Colors.white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ))));

  /*Future dialogSpareUpdate(
          BuildContext context,
          Size size,
          TextEditingController marcacontroll,
          TextEditingController piezacontroll,
          TextEditingController preciocontroll,
          TextEditingController stockcontroll,
          TextEditingController telfproveedorcontroll,
          String id) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Actualizar Orden',
                    style: TextStyle(color: Colors.white)),
                //content: Text(error),
                actions: <Widget>[
                  Container(
                      width: size.width / 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            //fila con un container y un TextField para email
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    controller:
                                        marcacontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Marca",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    controller:
                                        piezacontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Pieza",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para email
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                    ], //para que solo se pueda poner un punto

                                    ///para que el teclado sea numerico

                                    controller:
                                        preciocontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Precio",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]{0,1}[0-9]*')),
                                    ],
                                    controller:
                                        stockcontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Stock",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]{0,1}[0-9]*')),
                                    ],
                                    controller:
                                        telfproveedorcontroll, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Teléfono del proveedor",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (marcacontroll.text.isEmpty ||
                                      piezacontroll.text.isEmpty ||
                                      preciocontroll.text.isEmpty ||
                                      stockcontroll.text.isEmpty ||
                                      telfproveedorcontroll.text.isEmpty) {
                                    String error =
                                        'Rellene todos los campos antes de guardar';
                                    DialogError dialogError = DialogError();
                                    dialogError.dialogError(context, error);
                                  } else {
                                    String marca = marcacontroll.text;
                                    String pieza =
                                        piezacontroll.text.toLowerCase();
                                    double precio =
                                        double.parse(preciocontroll.text);
                                    int stock = int.parse(stockcontroll.text);
                                    int telfproveedor =
                                        int.parse(telfproveedorcontroll.text);

//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

                                    base.updateSpare(id, marca, pieza, precio,
                                        stock, telfproveedor);

                                    marcacontroll.clear();
                                    piezacontroll.clear();
                                    preciocontroll.clear();
                                    stockcontroll.clear();
                                    telfproveedorcontroll.clear();

                                    Navigator.of(context).pop();
                                  }
                                }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                child: Text('Guardar',
                                    style: TextStyle(
                                        fontSize: size.height / 35,
                                        color: Colors
                                            .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ));

  Future dialogSpareDelete(BuildContext context, String id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Mecánico', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar esta orden?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  base.deleteSpare(id);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));*/


  Future<DateTime?> pickDateStart(BuildContext context)=> showDatePicker(
    context: context,
    initialDate:DateTime.now(),
    firstDate: DateTime(2020),
    lastDate:  DateTime(2200)
  );
  Future<DateTime?> pickDateEnd(BuildContext context, DateTime datestart)=> showDatePicker(
    context: context,
    initialDate:datestart,
    firstDate: datestart,
    lastDate:  DateTime(2200)
  );


  DropdownMenuItem<String> getdropdown(String item)=>
    DropdownMenuItem(value:item, child: Text(item),);
}*/



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tallermecanico/alertdialog/dialogError.dart';
import 'package:tallermecanico/databasesqlite/database.dart';
import 'package:tallermecanico/model/repairorder.dart';

class DialogRepairOrder {
  //TextEditingController idtxt = TextEditingController();
  TextEditingController vehiculotxt = TextEditingController();
  TextEditingController mecanicotxt =TextEditingController(); //variables para coger los textos de los TextField de email y contraseña
  TextEditingController horasreparaciontxt = TextEditingController();
  TextEditingController descripcionreparaciontxt = TextEditingController();
  TextEditingController fechainiciotxt = TextEditingController();
  TextEditingController fechafintxt = TextEditingController();

  String inicio = 'Inicio';
  String fin = 'Fin';
  var datestart; //la hago global para enviarla al calendario de fin para q no pueda poner dias anteriores a la fecha de inicio
  var dateend;

  DatabaseSqlite dt = DatabaseSqlite();

  String? mecanico;//values combobox
  String? vehiculo;

  /*String? dnimeca; //para el combobox
  String dnimecanico = '';
  String? matriculavehi; //para el combobox
  String matriculavehiculo = '';*/

  Future dialogRepairOrdersInsert(BuildContext context, Size size,
          List<String> listamecanicos, List<String> listavehiculos) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(
              builder: ((context, setState) => AlertDialog(
                    backgroundColor: Colors.grey[600],
                    title: Text('Añadir Orden',
                        style: TextStyle(color: Colors.white)),
                    //content: Text(error),
                    actions: <Widget>[
                      Container(
                          width: size.width / 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                    width: size.width / 1.4,
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint:Text('Elige vehículo'),
                                        value: vehiculo,
                                        items: listavehiculos.map((item)=>DropdownMenuItem<String>(
                                          value:item,
                                          child: Text(item) ,
                                        )).toList(),
                                        onChanged: (item)=>setState(()=>vehiculo=item),
                                        
                                        )
                                    
                                    
                                    
                                    
                                    
                                    /*DropdownButton<String>(
                                      hint: Text('Elige mecánico'),
                                      isExpanded: true,

                                      items: listamecanicos
                                          .map(getdropdown)
                                          .toList(),
                                      onChanged: (string) => setState(() {
                                        dnimecanico =
                                            string!; //esta variable cliente será la q se use para insertar los datos en sqlite,
                                        //debido a que esta variable debe ser String para que se pueda insertar

                                        dnimeca = string;
                                      }), //esta variable se usa para que el DropdownButton detecte el valor pulsado ya que está variable debe ser
                                      //String? la ? significa que esta variable puede ser nula, es decir que no requiere ser inicializada

                                      value: dnimeca,
                                    ),*/
                                  )
                                  //se convierte la lista de String a DropdownMenuItem<String>
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ), //para separar rows

                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                    width: size.width / 1.4,
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint:Text('Elige mecánico'),
                                        value: mecanico,
                                        items: listamecanicos.map((item)=>DropdownMenuItem<String>(
                                          value:item,
                                          child: Text(item) ,
                                        )).toList(),
                                        onChanged: (item)=>setState(()=>mecanico=item),
                                        
                                        )
                                  )
                                  //se convierte la lista de String a DropdownMenuItem<String>
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ), //para separar rows

                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                    width: size.width /
                                        1.4, //ancho del TextField en relación al ancho de la pantalla
                                    height: size.height / 17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              20)), //bordes circulares
                                      color: Colors.grey[700],
                                    ),
                                    child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ], //para que solo se pueda poner un punto
                                        controller:
                                            horasreparaciontxt, //se identifica el controlador del TextField
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 0, 229, 255)),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.circle_outlined),
                                            border: InputBorder.none,
                                            hintText: "Horas reparación",
                                            hintStyle: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ), //para separar rows

                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                    width: size.width /
                                        1.4, //ancho del TextField en relación al ancho de la pantalla
                                    height: size.height / 17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              20)), //bordes circulares
                                      color: Colors.grey[700],
                                    ),
                                    child: TextField(
                                        controller:
                                            descripcionreparaciontxt, //se identifica el controlador del TextField
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 0, 229, 255)),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.circle_outlined),
                                            border: InputBorder.none,
                                            hintText:
                                                "Descripción de la reparación",
                                            hintStyle: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Row(
                                //fila con un container y un TextField para contraseña
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Container(
                                    width: size.width / 3,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        datestart =await pickDateStart(context);
                                        setState(() {
                                          if(datestart!=null){
                                            inicio = DateFormat('yyyy-MM-dd').format(datestart!);
                                          }else{
                                            inicio='Inicio';
                                          }
                                          
                                        });
                                      },
                                      icon: Icon(Icons.calendar_today),
                                      label: Text(
                                        inicio,
                                        style: TextStyle(
                                            fontSize: size.height / 65,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 13,
                                  ),
                                  Container(
                                      width: size.width / 3,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          dateend = await pickDateEnd(
                                              context, datestart);
                                          setState(() {
                                            if(dateend!=null){
                                              fin = DateFormat('yyyy-MM-dd').format(dateend!);
                                            }else{
                                              fin='Fin';
                                            }
                                            
                                          });
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                          fin,
                                          style: TextStyle(
                                              fontSize: size.height / 65,
                                              color: Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ), //para separar rows
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (mecanico ==null||vehiculo == null||
                                          datestart == null) {
                                        String error =
                                            'Debe elegir al mecánico, el vehículo y la fecha de inicio';
                                        DialogError dialogError = DialogError();
                                        dialogError.dialogError(context, error);
                                      } else {
                                        /*var fechahoy=DateTime.now();
                                        String hoy = DateFormat('dd-MM-yyyy').format(datestart!);*/

                                        String id=vehiculo.toString()+'//'+inicio;

                                        var order = RepairOrder(
                                          id:id.toUpperCase(),
                                          vehiculo: vehiculo.toString(),
                                          mecanico: mecanico.toString(),
                                          horasreparacion:horasreparaciontxt.text,
                                          descripcionreparacion:descripcionreparaciontxt.text,
                                          inicio: inicio,
                                          fin: fin,
                                        );
//////////////////////////////////////capturar excepcion de PK repetida, q no se puedan escribir letras en telefono ni numeros en nombre

                                        dt.insertOrder(context, order);

                                        horasreparaciontxt.clear();
                                        descripcionreparaciontxt.clear();
                                        //matriculavehi =
                                           // 'Elige vehículo'; //restauro los combobox
                                       // dnimeca = 'Elige mecánico';
                                        //inicio='Inicio';//restauro los botones de fechas
                                        // fin='Fin';

                                        Navigator.of(context).pop();
                                      }
                                    }, //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                    child: Text('Guardar',
                                        style: TextStyle(
                                            fontSize: size.height / 35,
                                            color: Colors
                                                .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ))));

  Future dialogOrderUpdate(
          BuildContext context,
          Size size,

          List<String> listamecanicos,TextEditingController horasreparaciontxt,TextEditingController descripcionreparaciontxt,String fechafin,String? idmecanico,
          String idord,String vehiculomatri,String fechainicio



          ) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>StatefulBuilder(builder: ((context, setState) => AlertDialog(
                backgroundColor: Colors.grey[600],
                title: Text('Actualizar Orden',
                    style: TextStyle(color: Colors.white)),
                //content: Text(error),
                actions: <Widget>[
                  Container(
                      width: size.width / 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                             Container(
                          
                          width: size.width /
                                1.4,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            
                            value: idmecanico,
                            items: listamecanicos.map((item)=>DropdownMenuItem<String>(
                              value:item,
                              child: Text(item) ,
                            )).toList(),
                            onChanged: (item)=>setState(()=>idmecanico=item),
                            
                            ) )
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ], 
                                    controller:
                                        horasreparaciontxt, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Horas reparación",
                                        hintStyle:
                                            TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para email
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                width: size.width /
                                    1.4, //ancho del TextField en relación al ancho de la pantalla
                                height: size.height / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)), //bordes circulares
                                  color: Colors.grey[700],
                                ),
                                child: TextField(
                                    


                                    controller:
                                        descripcionreparaciontxt, //se identifica el controlador del TextField
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 0, 229, 255)),
                                        ),
                                        prefixIcon: Icon(Icons.circle_outlined),
                                        border: InputBorder.none,
                                        hintText: "Descripción de la reparación",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            //fila con un container y un TextField para contraseña
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              Container(
                                      width: size.width / 3,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          DateTime date = DateTime.parse(fechainicio);//convierto la fecha de inicio a datetime para pasarla al metodo pickDateEnd


                                          dateend = await pickDateEnd(
                                              context, date);
                                          setState(() {
                                            if(dateend!=null){
                                              fechafin = DateFormat('yyyy-MM-dd').format(dateend!);
                                            }else{
                                              fechafin='Fin';
                                            }
                                            
                                          });
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                          fechafin,
                                          style: TextStyle(
                                              fontSize: size.height / 65,
                                              color: Colors.white),
                                        ),
                                      )),
                            ]
                          ),

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          

                          const SizedBox(
                            height: 8,
                          ), //para separar rows

                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            children: [
                              TextButton(
                                onPressed: () {
                                  
                                    


                                    var order = RepairOrder(
                                          id:idord,
                                          vehiculo: vehiculomatri,
                                          mecanico: idmecanico.toString(),
                                          horasreparacion:horasreparaciontxt.text,
                                          descripcionreparacion:descripcionreparaciontxt.text,
                                          inicio:fechainicio,
                                          fin: fechafin,
                                        );


                                    dt.updateOrder(context,order,idord);

                                    
                                    descripcionreparaciontxt.clear();
                                    horasreparaciontxt.clear();

                                    Navigator.of(context).pop();
                                  },
                                 //Navigator.popUntil(context, (route) => route.isFirst),//regresa hasta la primera ruta que es el main, y el main muestra home al estar loggeado el usuario
                                child: Text('Guardar',
                                    style: TextStyle(
                                        fontSize: size.height / 35,
                                        color: Colors
                                            .white)), //esto nos permite eliminar el indicador de carga que se lanza en el login
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ))));

  Future dialogOrderDelete(BuildContext context, String id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[600],
            title:
                Text('Borrar Mecánico', style: TextStyle(color: Colors.white)),
            content: Text('¿Estas seguro de borrar esta orden?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async{
                  await dt.deleteOrder(context,id);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ));

  Future<DateTime?> pickDateStart(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2200));
  Future<DateTime?> pickDateEnd(BuildContext context, DateTime datestart) =>
      showDatePicker(
          context: context,
          initialDate: datestart,
          firstDate: datestart,
          lastDate: DateTime(2200));

  
}
