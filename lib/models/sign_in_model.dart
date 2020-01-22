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

  Future <String> getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("${Env.environment['baseUrl']}/sign_in", data: {"email": email, "password": password});
      return(response.statusMessage);
    } catch (e) {
      return(e.toString());
    }
  }
}