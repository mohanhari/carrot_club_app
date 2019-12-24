//import 'package:image_picker/image_picker.dart';
//import 'dart:io';
//import 'package:camera/camera.dart';
//import 'package:flutter/material.dart';
//import 'package:path/path.dart' show join;
//import 'package:path_provider/path_provider.dart';
//
//
//class UploadFiles extends StatefulWidget {
//  @override
//  _UploadFilesState createState() => _UploadFilesState();
//}
//
//class _UploadFilesState extends State<UploadFiles> {
//  var cameras;
//  var firstCamera;
//  CameraController controller;
//  Future<void> _initializeControllerFuture;
//
//  void initializeCamera () async {
//    cameras = await availableCameras();
//    controller = CameraController(
//      // Get a specific camera from the list of available cameras.
//      cameras[0],
//      // Define the resolution to use.
//      ResolutionPreset.medium,
//    );
//
//    // Next, initialize the controller. This returns a Future.
//    _initializeControllerFuture = controller.initialize();
////    firstCamera = cameras.first;
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    initializeCamera();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Take a picture')),
//      // Wait until the controller is initialized before displaying the
//      // camera preview. Use a FutureBuilder to display a loading spinner
//      // until the controller has finished initializing.
//      body: FutureBuilder<void>(
//        future: _initializeControllerFuture,
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.done) {
//            // If the Future is complete, display the preview.
//            return CameraPreview(controller);
//          } else {
//            // Otherwise, display a loading indicator.
//            return Center(child: CircularProgressIndicator());
//          }
//        },
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.camera_alt),
//        // Provide an onPressed callback.
//        onPressed: () async {
//          // Take the Picture in a try / catch block. If anything goes wrong,
//          // catch the error.
//          try {
//            // Ensure that the camera is initialized.
//            await _initializeControllerFuture;
//
//            // Construct the path where the image should be saved using the
//            // pattern package.
//            final path = join(
//              // Store the picture in the temp directory.
//              // Find the temp directory using the `path_provider` plugin.
//              (await getTemporaryDirectory()).path,
//              '${DateTime.now()}.png',
//            );
//
//            // Attempt to take a picture and log where it's been saved.
//            await controller.takePicture(path);
//
//            // If the picture was taken, display it on a new screen.
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => DisplayPictureScreen(imagePath: path),
//              ),
//            );
//          } catch (e) {
//            // If an error occurs, log the error to the console.
//            print(e);
//          }
//        },
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    controller?.dispose();
//    super.dispose();
//  }
//}
//
//class DisplayPictureScreen extends StatelessWidget {
//  final String imagePath;
//
//  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Display the Picture')),
//      // The image is stored as a file on the device. Use the `Image.file`
//      // constructor with the given path to display the image.
//      body: Image.file(File(imagePath)),
//    );
//  }
//}
//
////  File _image;
////  String _retrieveDataError;
////
////  Future<void> retrieveLostData() async {
////    final LostDataResponse response = await ImagePicker.retrieveLostData();
////    if (response == null) {
////      return;
////    }
////    if (response.file != null) {
////      setState(() {
////        if (response.type == RetrieveType.video) {
////          print('video');
////        } else {
////          print('image');
////          _image = response.file;
////        }
////      });
////    } else {
////      _retrieveDataError = response.exception.code;
////    }
////  }
////
////
////
////  Future getImage() async {
////    var image = await ImagePicker.pickImage(source: ImageSource.camera);
////
////    setState(() {
////      print('test');
////      _image = image;
////    });
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: Text('Image Picker Example'),
////      ),
////      body: Center(
////        child:FutureBuilder<void>(
////          future: retrieveLostData(),
////          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
////            switch (snapshot.connectionState) {
////              case ConnectionState.none:
////              case ConnectionState.waiting:
////                return const Text(
////                  'You have not yet picked an image.',
////                  textAlign: TextAlign.center,
////                );
////              case ConnectionState.done:
////                return _image == null ? Text('no data') : Image.file(_image);
////              default:
////                if (snapshot.hasError) {
////                  return Text(
////                    'Pick image/video error: ${snapshot.error}}',
////                    textAlign: TextAlign.center,
////                  );
////                } else {
////                  return const Text(
////                    'You have not yet picked an image.',
////                    textAlign: TextAlign.center,
////                  );
////                }
////            }
////          },
////        )
////      ),
////      floatingActionButton: FloatingActionButton(
////        onPressed: getImage,
////        tooltip: 'Pick Image',
////        child: Icon(Icons.add_a_photo),
////      ),
////    );
////  }
////}
