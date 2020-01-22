import 'package:carrot_club_app/models/file_upload.dart';
import 'package:carrot_club_app/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';


class UploadFiles extends StatefulWidget {
  @override
  _UploadFilesState createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {

  FileUpload fileUpload = new FileUpload();

  Future showSuccessMessage(title, subtitle, callFunction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              if(callFunction)
                getImage();
            },
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    try{
//      var image = await ImagePicker.pickImage(source: ImageSource.camera);
//      fileUpload.image = image;
      String imagePath = await EdgeDetection.detectEdge;
      fileUpload.image_path = imagePath;
      var message = await fileUpload.uploadImage();
      setState(() {
        if(message == 'Created'){
          showSuccessMessage('Success', 'The file has been uploaded. We will notify once the process is completed', false);
        }
        else {
          SharedWidgets().errorDialog(context, 'File upload failed');
          fileUpload.image_path = null;
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
        child: fileUpload.image_path == null ? Text(' No data') : Image.file(File(fileUpload.image_path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSuccessMessage('Note', 'Take a Picture with the whole bill and with good quality for better results', true),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
