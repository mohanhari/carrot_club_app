import 'package:carrot_club_app/pages/landing_pages/notification_page.dart';
import 'package:carrot_club_app/pages/landing_pages/reward_details.dart';
import 'package:carrot_club_app/pages/landing_pages/upload_files.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:carrot_club_app/pages/login_page/login.dart';
import 'package:carrot_club_app/pages/login_page/sign_in.dart';
import 'package:carrot_club_app/pages/login_page/sign_up.dart';

var rootHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new Login();
  },
);

var signInHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SignIn();
  },
);

var signUpHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SignUp();
  },
);

var rewardPointHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new RewardPointDetails(params["order_id"][0]);
  },
);

var uploadFileHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new UploadFiles();
  },
);

var notificationHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new NotificationPage();
  },
);