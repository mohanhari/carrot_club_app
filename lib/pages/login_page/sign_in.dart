import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:carrot_club_app/models/sign_in_model.dart';
import 'package:carrot_club_app/widgets/shared_widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInModel signInModel = new SignInModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _validateInputs() async{
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      var status = await signInModel.getHttp();
      if(status == 'OK') {
        Navigator.pushNamed(context, Routes.UPLOAD_FILE);
      }
      else {
        SharedWidgets().errorDialog(context, 'Incorrect Login Details');
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: _buildText('SIGN IN', 20.0),
        ),
        onPressed: () {
          _validateInputs();
        },
      ),
    );
  }

  Widget _buildTacCode () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 15,
          child: new TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter the password here',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            onSaved: (String value) {
              signInModel.tacCode = value;
            },
            validator: (value) => signInModel.validateTacCode(value),
            obscureText: true,
//            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 15.0,),
//        Flexible(
//          flex: 5,
//          child: InkWell(
//            child: Text(
//              'GET CODE',
//              style: TextStyle(
//                color: Colors.blue
//              ),
//            ),
//          )
//        ),
      ],
    );
  }

  Widget _buildPhoneNumberField () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Flexible(
//          flex: 2,
//          child: new TextFormField(
//            decoration: InputDecoration(
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(8.0))),
//            initialValue: 'MY (60)',
//            enabled: false,
//          ),
//        ),
//        SizedBox(width: 10.0,),
        Flexible(
          flex: 6,
          child: new TextFormField(
            decoration: InputDecoration(
                hintText: 'e.g. john@gmail.com',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            onSaved: (String value) {
              signInModel.mobileNum = value;
            },
            validator: (value) => signInModel.validateMobileNumber(value),
//            keyboardType: TextInputType.number,
          ),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              new ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Image(
                  width: 40.0,
                  image: AssetImage('assets/images/carrot_club_logo.jpeg'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(width: 10.0,),
              Text('CarrotClub'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'SIGN IN',
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'EMAIL',
                  ),
                  SizedBox(height: 20.0),
                  _buildPhoneNumberField(),
                  SizedBox(height: 20.0),
                  Text(
                    'PASSWORD',
                  ),
                  SizedBox(height: 20.0),
                  _buildTacCode(),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
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
        ));
  }
}
