import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:carrot_club_app/utils/constants.dart';
import 'package:carrot_club_app/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  SharedWidgets sharedWidgets = new SharedWidgets();

  Widget _raisedButton (text, changeColor) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: changeColor ? Constants.grey : null,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: _buildText(text, 20.0),
        ),
        onPressed: () {
          changeColor ? Navigator.pushNamed(context, Routes.SIGN_UP) : Navigator.pushNamed(context, Routes.SIGN_IN);
        },
      ),
    );
  }

  Widget _buildText (text, size) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        letterSpacing: 0.5,
      ),
    );
  }
  
  Widget _loginForm () {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40.0, 30.0, 30.0, 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//            SizedBox(height: 200,),
          _raisedButton('Sign In', false),
          SizedBox(height: 30.0,),
          _raisedButton('Sign Up', true),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          sharedWidgets.buildBackgroundImage(),
          sharedWidgets.buildLogo(),
          Center(child: _loginForm()),
        ],
      ),
    );
  }
}
