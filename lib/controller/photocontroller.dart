import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';

class PhotoController {
  
 Future selectFile() async{
   final result =await FilePickerWeb.platform.pickFiles(
     allowMultiple: false,
     type:FileType.image,


   );
 }


}
