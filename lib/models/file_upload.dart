import 'package:carrot_club_app/configs/NetWorkCall.dart';
import 'package:dio/dio.dart';
import 'package:carrot_club_app/configs/env.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileUpload {
  String imagePath;

  Future<String> uploadImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('fcm_token');
    FormData formData = new FormData.fromMap({
      "order": {
        "name": basename(imagePath),
        "receipt": await MultipartFile.fromFile(imagePath, filename: basename(imagePath)),
        "token": token,
      }
    });
    Response response;
    Dio dio = NetworkCall().getDio();
    response = await dio.post("${Env.environment['baseUrl']}/orders", data: formData);
    return(response.statusMessage);
  }
}