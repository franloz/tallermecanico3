import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sqflite/sqflite.dart';

import '../databases/database.dart';

class PdfApi {
  /*static Future<File>generateCenteredText(String idorden,String text)async{
    final pdf=Document();//se crea documento

    pdf.addPage(Page(//añade pagina
      build:(context)=>Center(child:Text(text) )
    
    ));

    return saveDocument(name:idorden+'factura.pdf',pdf:pdf);//metodo 
  }*/

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save(); //se guarda el documento

    final dir =
        await getApplicationDocumentsDirectory(); //directorio de la aplicacion
    final file = File("${dir.path}/$name"); //creamos archivo

    await file.writeAsBytes(bytes); //se escribe en el archivo

    return file; //se devuelve el archivo
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  //mas complejo
  static Future<File> generate(String idorden, String baseimponible,
      String descuento, String iva, String totalfactura) async {
    final pdf = Document(); //se crea documento
    ////////////////////
    final headers = [
      'Recambio',
      'Cantidad',
      'Precio*unidad'
    ]; //encabezado de la tabla

    final listdata =
        []; //array para introducir los datos que se mostraran en la tabla del pdf

    DatabaseSqlite db = DatabaseSqlite();
    Database database = await db.openDB();

    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT idrecambio,cantidad  FROM LineasReparacion WHERE idorden = ?",
        [idorden]); //se obtiene el id del recambio y la cantidad
    for (var element in maps) {
      //se recorre la lista de lineas y por cada recambio se saca su precio

      String idrecambio = element[
          'idrecambio']; //se obtiene el id del recambio y la cantidad de cada linea

      int cantidad = element['cantidad'];

      var resultSet = await database.rawQuery(
          "SELECT precio FROM Recambios WHERE id = ?",
          [idrecambio]); //se obtiene el precio del recambio
      var dbItem = resultSet.first;
      String preciostring =
          dbItem['precio'] as String; //se coge el precio de este recambio

      DataTable datos = DataTable(
          recambio: idrecambio,
          cantidad: cantidad.toString(),
          preciounidad: preciostring); //creo objetos con estos datos

      listdata
          .add(datos); //y los inserto en una lista para mostrarlo en la tabla
    }

    final data = listdata
        .map((data) => [data.recambio, data.cantidad, data.preciounidad])
        .toList(); //se convierten los datos de la lista a List<dynamic> para poder mostrarlos en la tabla
    /////////////////////
    //////////
    var select = await database
        .rawQuery("SELECT * FROM OrdenesReparacion WHERE id = ?", [idorden]);
    var object = select.first;

    String id = object['id'] as String;
    String vehiculo = object['vehiculo'] as String;
    String horasreparacion = object['horasreparacion'] as String;
    String preciohora = object['preciohora'] as String;
    String descripcionreparacion = object['descripcionreparacion'] as String;
    String fechainicio = object['inicio'] as String;
    String fechafin = object['fin'] as String;
///////////////////
    ///
    var select3 = await database
        .rawQuery("SELECT * FROM Vehiculos WHERE matricula = ?", [vehiculo]);
    var object3 = select3.first;

    String dnicliente = object3['clientedni'] as String;

    pdf.addPage(MultiPage(
        //añade pagina
        build: (context) => <Widget>[
              Container(
                //titulo
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2, color: PdfColors.blue))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Factura',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black))
                ]),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(children: [
                              Text('Cliente: ' + dnicliente,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black)),
                              Text('Vehículo: ' + vehiculo,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black)),
                            ])
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(children: [
                              Text('Id factura:' + id,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black)),
                              Text('Fecha inicio:' + fechainicio,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black)),
                              Text('Fecha fin:' + fechafin,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black)),
                            ])
                          ]),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Table.fromTextArray(headers: headers, data: data),

              ///tabla

              SizedBox(
                height: 20,
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [
                  Text('Horas dedicadas: ' + horasreparacion,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                  Text('Precio hora: ' + preciohora,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                  Text('Descripcion de la reparacion: ' + descripcionreparacion,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                ]),
              ]),

              SizedBox(
                height: 40,
              ),

              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Column(children: [
                  Text('Base imponible: ' + baseimponible + ' euros',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                  Text('Descuento: ' + descuento + '%',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                  Text('Iva: ' + iva + '%',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                  Text('Total factura: ' + totalfactura + ' euros',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black)),
                ])
              ])
            ]));

    return saveDocument(
        name: idorden + 'factura.pdf', pdf: pdf); //se guarda el pdf
  }
}

class DataTable {
  final String recambio;
  final String cantidad;
  final String preciounidad;

  const DataTable(
      {required this.recambio,
      required this.cantidad,
      required this.preciounidad});
}
