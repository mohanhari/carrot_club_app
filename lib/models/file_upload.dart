import 'dart:io';
import 'package:dio/dio.dart';
import 'package:carrot_club_app/configs/env.dart';
import 'package:path/path.dart';

class FileUpload {
  File image;

  Future<String> uploadImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FormData formData = new FormData.fromMap({
      "order": {
        "name": basename(image.path),
        "receipt": await MultipartFile.fromFile(image.path,filename: basename(image.path)),
      }
    });
    Response response;
    print(image);
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

    print(response.statusMessage);
    return(response.statusMessage);
  }
}