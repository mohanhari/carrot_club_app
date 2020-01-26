import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'handler.dart';

class  Routes {
  static const String LOGIN_PAGE = "/";
  static const String SIGN_IN = "/sign_in";
  static const String SIGN_UP = "/sign_up";
  static const String QR_CODE = "/qr_code";
  static const String UPLOAD_FILE = "/upload_file";
  static const String REWARD_POINT = "/reward_point";
  static const String NOTIFICATIONS = "/notifications";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
    router.define(LOGIN_PAGE, handler: rootHandler, transitionType: TransitionType.inFromBottom);
    router.define(SIGN_IN, handler: signInHandler, transitionType: TransitionType.inFromBottom);
    router.define(SIGN_UP, handler: signUpHandler, transitionType: TransitionType.fadeIn);
    router.define(UPLOAD_FILE, handler: uploadFileHandler);
    router.define(REWARD_POINT, handler: rewardPointHandler);
    router.define(NOTIFICATIONS, handler: notificationHandler);
  }
}