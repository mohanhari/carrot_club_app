import 'package:carrot_club_app/configs/navigation_services.dart';
import 'package:carrot_club_app/configs/service_locator.dart';
import 'package:carrot_club_app/pages/login_page/login.dart';
import 'package:carrot_club_app/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:carrot_club_app/configs/routes/application.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:carrot_club_app/configs/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp () {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<GlobalProvider>(
      create: (_) => new GlobalProvider(),
      child: BotToastInit(
        child: MaterialApp(
          onGenerateRoute: Application.router.generator,
          navigatorKey: locator<NavigationService>().navigatorKey,
          home: HomePage(),
          darkTheme: Themes().darkTheme,
          theme: Themes().defaultTheme,
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var navigationService = locator<NavigationService>();
  GlobalProvider globalProvider;

  @override
  void initState() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLanch Called");
//        print(msg["data"]["screen"]);
//        if(msg["data"]["screen"] != null){
//          Navigator.pushNamedAndRemoveUntil(context, msg["data"]["screen"], (Route<dynamic> route) => false);
//        }
        return null;
      },
      onResume: (Map<String, dynamic> msg) {
        if(msg["data"]["screen"] != null ){
          if(msg["data"]["order_id"]?.isNotEmpty ?? true)
            navigationService.navigatorKey.currentState.pushNamedAndRemoveUntil(msg["data"]["screen"] + '?order_id=${msg["data"]["order_id"]}', (Route<dynamic> route) => false);
        }
        return null;
      },
      onMessage: (Map<String, dynamic> msg) async{
        globalProvider.incrementCounter();
        globalProvider.addMessage(msg["notification"]["title"], msg["data"]["order_id"], msg["notification"]["body"]);
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          alert: true,
          badge: true,
        )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print('IOS Settings Registered');
    });
    firebaseMessaging.getToken().then((token) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      globalProvider = Provider.of<GlobalProvider>(context);
      return Login();
  }
}
