import 'package:carrot_club_app/models/file_upload.dart';
import 'package:carrot_club_app/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class UploadFiles extends StatefulWidget {
  @override
  _UploadFilesState createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {

  FileUpload fileUpload = new FileUpload();

  Future showSuccessMessage() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text('Success'),
          subtitle: Text('The file has been uploaded. We will notify once the process is completed'),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    try{
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      fileUpload.image = image;
      var message = await fileUpload.uploadImage();
      setState(() {
        if(message == 'Created'){
          showSuccessMessage();
        }
        else {
          SharedWidgets().errorDialog(context, 'File upload failed');
          fileUpload.image = null;
        }
      });
    }
    catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
//        child:FutureBuilder<void>(
//          future: retrieveLostData(),
//          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//            switch (snapshot.connectionState) {
//              case ConnectionState.none:
//              case ConnectionState.waiting:
//                return const Text(
//                  'You have not yet picked an image.',
//                  textAlign: TextAlign.center,
//                );
//              case ConnectionState.done:
//                return _image == null ? Text('no data') : Image.file(_image);
//              default:
//                if (snapshot.hasError) {
//                  return Text(
//                    'Pick image/video error: ${snapshot.error}}',
//                    textAlign: TextAlign.center,
//                  );
//                } else {
//                  return const Text(
//                    'You have not yet picked an image.',
//                    textAlign: TextAlign.center,
//                  );
//                }
//            }
//          },
//        )
      child: fileUpload.image == null ? Text(' No data') : Image.file(fileUpload.image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
