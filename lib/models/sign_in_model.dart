import 'package:dio/dio.dart';
import 'package:carrot_club_app/configs/env.dart';

class SignInModel {
  String mobileNum, tacCode;

  String validateMobileNumber(String value){
    if(value.isEmpty)
      return('Please enter phone number!');

    return null;

//    RegExp regExp = new RegExp(r"^\d{9}$");
//
//    if (regExp.hasMatch(value)) {
//      return null;
//    }
//
//    return 'Phone number is not valid';
  }

  String validateTacCode(String value){
    if(value.isEmpty)
      return('Please enter TAC code!');

    return null;

//    RegExp regExp = new RegExp(r"^\d{4}$");
//
//    if (regExp.hasMatch(value)) {
//      return null;
//    }
//
//    return 'TAC code is not valid';
  }

  Future <String> getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("${Env.environment['baseUrl']}/sign_in", data: {"email": mobileNum, "password": tacCode});
      print(response.headers);
      return(response.statusMessage);
    } catch (e) {
      return(e.toString());
    }
  }
}