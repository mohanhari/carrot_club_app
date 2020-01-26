import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:carrot_club_app/models/sign_in_model.dart';
import 'package:carrot_club_app/widgets/shared_widgets.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInModel signInModel = new SignInModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedWidgets sharedWidgets = new SharedWidgets();
  bool hidePassword = true;
  bool isLoading = false;
  bool _autoValidate = false;

  void _validateInputs() async{
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        isLoading = true;
      });
      var response = await signInModel.getHttp();
      if(response.toString() == 'error') {
        SharedWidgets().errorDialog(context, 'Incorrect Login Details');
      }
      else if(response.statusMessage == 'OK') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data["remember_token"]);
        Navigator.pushNamedAndRemoveUntil(context, Routes.UPLOAD_FILE, (Route<dynamic> route) => false);
      }
      else {
        SharedWidgets().errorDialog(context, 'Incorrect Login Details');
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isLoading ? Loading(indicator: BallBeatIndicator(),size: 30,) : _buildText('SIGN IN', 20.0),
        ),
        disabledColor: Theme.of(context).primaryColor,
        onPressed: isLoading ? null : () {
          _validateInputs();
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "Email",
          hintText: 'e.g. john@gmail.com',
          prefixIcon: Icon(Icons.account_circle, size: 30,),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      onSaved: (String value) {
        signInModel.email = value;
      },
      validator: (value) => signInModel.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: "Password",
          hintText: 'Enter the password here',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
          ),
          prefixIcon: Icon(Icons.lock, size: 30,),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      onSaved: (String value) {
        signInModel.password = value;
      },
      validator: (value) => signInModel.validatePassword(value),
      keyboardType: TextInputType.text,
      obscureText: hidePassword,
    );
  }

  Widget _buildText(text, size) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              _buildEmailField(),
              SizedBox(height: 20.0),
              _buildPasswordField(),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                child: _buildButton(),
              ),
              SizedBox(height: 25.0),
              Center(
                child: InkWell(
                  child: Text(
                    'Don\'t have a account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.SIGN_UP);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          sharedWidgets.buildBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 50,),
                sharedWidgets.buildLogo(),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white,
                    child: _buildForm(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
