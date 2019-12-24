//import 'dart:async';
//
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//class ScanScreen extends StatefulWidget {
//  @override
//  _ScanState createState() => new _ScanState();
//}
//
//class _ScanState extends State<ScanScreen> {
//  String barcode = "";
//
//  @override
//  initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: new AppBar(
//          title: new Text('QR Code Scanner'),
//        ),
//        body: new Center(
//          child: new Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                child: RaisedButton(
//                    textColor: Colors.white,
//                    onPressed: scan,
//                    child: const Text('START CAMERA SCAN')
//                ),
//              )
//              ,
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                child: Text(barcode, textAlign: TextAlign.center,),
//              )
//              ,
//            ],
//          ),
//        ));
//  }
//
//  Future scan() async {
//    try {
//      String barcode = await FlutterBarcodeScanner.scanBarcode('#000000', 'Cancel', false, ScanMode.DEFAULT);
//      setState(() => this.barcode = barcode);
//    } on PlatformException catch (e) {
//      if (e.code == '') {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException{
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  }
//}