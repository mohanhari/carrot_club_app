import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class SharedWidgets {
  Widget buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/carrot_cover_photo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildMaterialDialog (BuildContext context, content) {
    return AlertDialog(
      title: const Text('ERROR'),
      content: Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('ok'),
        ),
      ],
    );
  }

  Widget buildIosDialog (BuildContext context, content) {
    return CupertinoAlertDialog(
      title: const Text('ERROR'),
      content: Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('ok'),
        ),
      ],
    );
  }

  Future errorDialog (BuildContext context, content) {
    return showDialog(
      context: context,
        builder: (BuildContext context) {
          return Platform.isIOS ? buildIosDialog(context, content) : buildMaterialDialog(context, content);
        });
  }

  Widget buildLogo () {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 30.0, 30.0, 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: new ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Image(
                  width: 80.0,
                  image: AssetImage('assets/images/carrot_club_logo.jpeg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 30,),
            Flexible(
                flex: 2,
                child: Text(
                  'CarrotClub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}