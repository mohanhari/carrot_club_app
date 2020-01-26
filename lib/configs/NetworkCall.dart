import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_services.dart';
import 'service_locator.dart';

class NetworkCall{
  Dio getDio() {
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(Options options) async {
          // If no token, request token firstly and lock this interceptor
          // to prevent other request enter this interceptor.
          dio.interceptors.requestLock.lock();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          // We use a new Dio(to avoid dead lock) instance to request token.
          options.headers["token"] = 'Bearer $token';
          //Set the token to headers
          dio.interceptors.requestLock.unlock();
          return options; //continue
        },
        onError: (DioError e) {
          if(e?.response?.statusCode == 401){
            locator<NavigationService>().navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.SIGN_IN, (Route<dynamic> route) => false);
          }
        },
//        onResponse: (Response response){
//          print(response);
//          if(response?.statusCode == 401){
//            locator<NavigationService>().navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.SIGN_IN, (Route<dynamic> route) => false);
//            BotToast.showText(text: 'Please Login first');
//          }
//        }
    ));
    return dio;
  }
}