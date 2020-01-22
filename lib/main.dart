import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:carrot_club_app/configs/routes/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carrot_club_app/configs/routes/routes.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:carrot_club_app/configs/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bot_toast/bot_toast.dart';

void main() => runApp(MyApp());

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
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLanch Called");
        return null;
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume Called");
        return null;
      },
      onMessage: (Map<String, dynamic> msg) async{
        BotToast.showSimpleNotification(
            title: "${msg["notification"]["title"]}",
//            subTitle: "yes!",
            onTap: () {
              BotToast.showText(text: 'Tap toast');
            },
            onLongPress: () {
              BotToast.showText(text: 'Long press toast');
            },
            animationDuration:
            Duration(milliseconds: 200),
            animationReverseDuration:
            Duration(milliseconds: 200),
            duration: Duration(seconds: 5));
//        return;
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

    return BotToastInit(
      child: MaterialApp(
        onGenerateRoute: Application.router.generator,
        initialRoute: Routes.LOGIN_PAGE,
        darkTheme: Themes().darkTheme,
        theme: Themes().defaultTheme,
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//  File image;
//
//  void _incrementCounter() async{
//    var imagepath = await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      image = imagepath;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$image',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
