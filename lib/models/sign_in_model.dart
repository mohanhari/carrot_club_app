import 'package:dio/dio.dart';
import 'package:carrot_club_app/configs/env.dart';

class SignInModel {
  String email, password;

  String validateEmail(String value){
    if(value.isEmpty)
      return('Please enter the Email!');

    RegExp regExp = new RegExp(r"^\S+@\S+\.\S+$");

    if (regExp.hasMatch(value))
      return null;

    return 'Email is not valid';
  }

  String validatePassword(String value){
    if(value.isEmpty)
      return('Please enter Password!');

    return null;
  }

  Future <dynamic> getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      var data = {
        "session":{
          "email": email,
          "password": password
        }
      };

      response = await dio.post("${Env.environment['baseUrl']}/sign_in", data: data);
      return(response);
    } catch (e) {
      return("error");
    }
  }
}