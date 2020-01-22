import 'dart:io';
import 'package:dio/dio.dart';
import 'package:carrot_club_app/configs/env.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileUpload {
  String image_path;

  Future<String> uploadImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('fcm_token');
    FormData formData = new FormData.fromMap({
      "order": {
        "name": basename(image_path),
        "receipt": await MultipartFile.fromFile(image_path, filename: basename(image_path)),
        "token": token,
      }
    });
    Response response;
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(Options options) async {
          // If no token, request token firstly and lock this interceptor
          // to prevent other request enter this interceptor.
          dio.interceptors.requestLock.lock();
          // We use a new Dio(to avoid dead lock) instance to request token.
          options.headers["token"] = 'c9b6f4ea92a176b4e8c48de402b54ebd5a03c297';
          //Set the token to headers
//          options.headers["token"] = response.data["data"]["token"];
          dio.interceptors.requestLock.unlock();
          return options; //continue
        }
    ));
    response = await dio.post("${Env.environment['baseUrl']}/orders", data: formData);
    return(response.statusMessage);
  }
}