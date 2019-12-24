import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'handler.dart';

class  Routes {
  static const String LOGIN_PAGE = "/";
  static const String SIGN_IN = "/sign_in";
  static const String SIGN_UP = "/sign_up";
  static const String QR_CODE = "/qr_code";
  static const String UPLOAD_FILE = "/upload_file";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
    router.define(LOGIN_PAGE, handler: rootHandler, transitionType: TransitionType.inFromBottom);
    router.define(SIGN_IN, handler: signInHandler, transitionType: TransitionType.inFromBottom);
    router.define(SIGN_UP, handler: signUpHandler, transitionType: TransitionType.fadeIn);
//    router.define(QR_CODE, handler: qrCodeHandler);
    router.define(UPLOAD_FILE, handler: uploadFileHandler);
  }
}

//class Router {
//
//  static Route<dynamic> generateRoute(RouteSettings settings) {
//    switch (settings.name) {
//      case Constants.LOGIN_PAGE:
//        return MaterialPageRoute(
//            builder: (_) => Login()
//        );
//
//      case Constants.SIGN_IN:
//        return MaterialPageRoute(
//            builder: (_) => SignIn()
//        );
//
//      case Constants.SIGN_UP:
//        return MaterialPageRoute(
//            builder: (_) => SignUp()
//        );
//
//      case Constants.Qr_CODE:
//        return MaterialPageRoute(
//            builder: (_) => ScanScreen()
//        );
//
//      default:
//        return MaterialPageRoute(
//            builder: (_) => Scaffold(
//              body: Center(
//                  child: Text('No route defined for ${settings.name}')),
//            ));
//    }
//  }
//}