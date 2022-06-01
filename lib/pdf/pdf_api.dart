import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';


class PdfApi{
  static Future<File>generateCenteredText(String idorden,String text)async{
    final pdf=Document();//se crea documento

    pdf.addPage(Page(//añade pagina
      build:(context)=>Center(child:Text(text) )
    
    ));

    return saveDocument(name:idorden+'factura.pdf',pdf:pdf);//metodo 
  }

  static Future<File> saveDocument({required String name,required Document pdf})async {

    final bytes=await pdf.save();//se guarda el documento

    final dir=await getApplicationDocumentsDirectory();//directorio de la aplicacion
    final file=File("${dir.path}/$name");//creamos archivo

    await file.writeAsBytes(bytes);//se escribe en el archivo

    return file;//se devuelve el archivo

  }

  static Future openFile(File file) async{

    final url=file.path;

    await OpenFile.open(url);

  }


  //mas complejo
   static Future<File>generate(String idorden,String text)async{
    final pdf=Document();//se crea documento

    pdf.addPage(MultiPage(//añade pagina
      build:(context)=> <Widget>[
        //Header(child: Text('Factura')),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Factura')


        ]),
        
        Row(
      children: <Widget>[
         SizedBox(
              height: 20,
            ),
        Expanded(
          flex: 1,
          child: Container(child:
            //width: MediaQuery.of(context).size.width * 0.25,
           // decoration: BoxDecoration(color: Colors.greenAccent),

           Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(children: [
                    Text('Cliente:'+''),
                    Text('Vehículo:'+''),
                  ])
                  

              ]),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(child:
            //width: MediaQuery.of(context).size.width * 0.25,
            //decoration: BoxDecoration(color: Colors.yellow),

            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 Column(children: [
                    Text('Id factura:'+''),
                    Text('Fecha inicio:'+''),
                    Text('Fecha fin:'+''),
                  ])

              ]),
          ),
        ),
        
      ],
    ),

     SizedBox(
              height: 20,
            ),

    Column(children: [
      Text('tabla'),
       Paragraph(text: 'id recambio'),
        Paragraph(text: 'cantidad recambio'),
        Paragraph(text: 'precio de cada recambio'),
    ]),

     SizedBox(
              height: 20,
            ),

    Column(
          
          children: [
            
            Text( 'horas dedicadas'),
            Text( 'precio hora'),
            Text( 'descripcion de la reparacion'),


    ]),

    SizedBox(
              height: 20,
            ),

    
    Row(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
              Column(children: [
                  Text( 'base imponible'),
                  Text( 'desuento'),
                  Text( 'iva'),

                  Text( 'total factura'),
                ])
                  

      ])
            
              


    




        
       /* Row(
          
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Cliente:'+''),
                  Text('Vehículo:'+''),

              ])
              
            ]),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Id factura:'+''),
                  Text('Fecha inicio:'+''),
                  Text('Fecha fin:'+''),

              ])
              
            ])
            
          

        ]),*/



       // Paragraph(text: 'idorden seria id factura'),
       // Paragraph(text: 'matricula'),
        //Paragraph(text: 'cliente'),
       // Paragraph(text: 'horas dedicadas'),
       // Paragraph(text: 'precio hora'),
       // Paragraph(text: 'descripcion de la reparacion'),
       // Paragraph(text: 'fecha inicio'),
        //Paragraph(text: 'fecha fin '),

        

       


      ]
    
    ));

    return saveDocument(name:idorden+'factura.pdf',pdf:pdf);//metodo 
  }

}