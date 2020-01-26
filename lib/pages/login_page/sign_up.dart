import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:carrot_club_app/models/registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Registration registration = new Registration();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate() && registration.termAndCondition) {
      form.save();
      Navigator.pushNamed(context, Routes.QR_CODE);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: _buildText('SIGN UP', 20.0),
        ),
        onPressed: () {
          _validateInputs();
        },
      ),
    );
  }

  Widget _buildTacCode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
            flex: 15,
            child: _buildTextFormField('TAC Code', 'Enter the code',
                registration.validateTacCode, TextInputType.text)),
        SizedBox(
          width: 15.0,
        ),
        Flexible(
            flex: 5,
            child: InkWell(
              child: Text(
                'GET CODE',
                style: TextStyle(color: Colors.blue),
              ),
            )),
      ],
    );
  }

  Widget _buildTextFormField(label, hintText, Function validate, inputType) {
    return new TextFormField(
      decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      onSaved: (String value) {
//                    newDetails.email = value;
      },
      validator: (value) => validate(value),
      keyboardType: inputType,
    );
  }

  Widget _buildIosDialog () {
    return CupertinoAlertDialog(
      title: const Text('PRIVACY POLICY'),
      content: Text('Policies'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            setState(() {
              registration.termAndCondition = true;
            });
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }

  Widget _buildMaterialDialog () {
    return AlertDialog(
      title: const Text('PRIVACY POLICY'),
      content: Text('Policies'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            setState(() {
              registration.termAndCondition = true;
            });
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Container(
      height: 40.0,
      child: CheckboxListTile(
        value: registration.termAndCondition,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool value) {
          setState(() {
            registration.termAndCondition = value;
          });
        },
        title: InkWell(
          child: Text(
            'Accept Privacy Policy',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: !registration.termAndCondition && _autoValidate
                    ? Colors.red
                    : null),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Platform.isIOS ? _buildIosDialog() : _buildMaterialDialog();
                });
          },
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: new TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            initialValue: 'MY (60)',
            enabled: false,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Flexible(
            flex: 6,
            child: _buildTextFormField('Phone Number', 'e.g. 123456789',
                registration.validateMobileNumber, TextInputType.number)),
      ],
    );
  }

  Widget _buildGender() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
      value: registration.gender,
      isDense: true,
      items: registration.genders.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          registration.gender = newValue;
        });
      },
      validator: (value) => registration.validateGender(value),
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
          centerTitle: false,
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
              SizedBox(
                width: 10.0,
              ),
              Text('CarrotClub', style: TextStyle(color: Colors.white),),
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
                    'SIGN UP',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20.0),
                  _buildTextFormField('Full Name', 'e.g. JohnSmith',
                      registration.validateName, TextInputType.text),
                  SizedBox(height: 20.0),
                  _buildTextFormField(
                      'Email Address',
                      'e.g. john@gmail.com',
                      registration.validateEmail,
                      TextInputType.emailAddress),
                  SizedBox(height: 20.0),
                  _buildTextFormField('NRIC', 'e.g. 981231011234',
                      registration.validateNricNumber, TextInputType.number),
                  SizedBox(height: 20.0),
                  _buildGender(),
                  SizedBox(height: 20.0),
                  _buildPhoneNumberField(),
                  SizedBox(height: 20.0),
                  _buildTacCode(),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _buildTermsAndConditions(),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: _buildButton(),
                  ),
                  SizedBox(height: 25.0),
                  Center(
                    child: InkWell(
                      child: Text(
                        'Already have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.SIGN_IN);
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
