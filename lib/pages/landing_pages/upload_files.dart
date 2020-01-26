import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:carrot_club_app/models/file_upload.dart';
import 'package:carrot_club_app/providers/global_provider.dart';
import 'package:carrot_club_app/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:badges/badges.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class UploadFiles extends StatefulWidget {
  @override
  _UploadFilesState createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  FileUpload fileUpload = new FileUpload();
  GlobalProvider globalProvider;
  var top = 0.0;
  var lists = [
    {"name":"My Profile", "icon": Icons.supervised_user_circle},
    {"name":"Redeem Points", "icon": Icons.card_giftcard},
    {"name":"Settings", "icon": Icons.settings},
    {"name":"View Uploads", "icon": Icons.file_upload},
    {"name":"Logout", "icon": Icons.power_settings_new},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future showSuccessMessage(title, subtitle, callFunction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              if (callFunction) getImage();
            },
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    try {
      String imagePath = await EdgeDetection.detectEdge;
      fileUpload.imagePath = imagePath;
      var message = await fileUpload.uploadImage();
      setState(() {
        if (message == 'Created') {
          showSuccessMessage(
              'Success',
              'The file has been uploaded successfully. We will notify once the process is completed',
              false);
        } else {
          SharedWidgets().errorDialog(context, 'File upload failed');
          fileUpload.imagePath = null;
        }
      });
    } catch (e) {
      print(e);
    }
  }


  Widget _buildGrids(BuildContext context) {
    return GridView.builder(
      itemCount: lists.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: InkWell(
              splashColor: Theme.of(context).primaryColor,
              onTap: lists[index]["name"] != "Logout" ? null : () {
                Navigator.pushNamedAndRemoveUntil(context, Routes.SIGN_IN, (Route<dynamic> route) => false);
              },
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(lists[index]["icon"], size: 50, color: Theme.of(context).primaryColor,),
                    Text(
                      lists[index]["name"],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _buildCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Card(
              elevation: 5.0,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("My Reward Points", style: Theme.of(context).textTheme.body2,),
                      globalProvider.rewardPoints == null ? Loading(indicator: BallBeatIndicator(), size: 30.0,) : Text(globalProvider.rewardPoints, style: Theme.of(context).textTheme.body2,)
                    ],
                  ),
                ),
            ),
          ),
          Expanded(child: _buildGrids(context),)
        ],
      ),
    );
  }

  _buildIconButton() {
    return IconButton(icon: Icon(Icons.notifications),
        onPressed: () {
          globalProvider.resetCounter();
          Navigator.pushNamed(context, Routes.NOTIFICATIONS);
        }
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              actions: <Widget>[
                globalProvider.messageCounter == 0 ? _buildIconButton() : Badge(
                  position: BadgePosition.topRight(top: 0, right: 3),
                  animationDuration: Duration(milliseconds: 300),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    globalProvider.messageCounter.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: _buildIconButton()
                )
              ],
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  centerTitle: true,
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top == 80.0 ? 1.0 : 0.0,
                        child: Text("Carrot Club",
                        style: TextStyle(
                          fontSize: 20.0,
                        )),
                    ),
                    background: Image.asset(
                      "assets/images/welcome_screen.png",
                      fit: BoxFit.fill,
                    ));
              }),
            ),
          ];
        },
        body: _buildCard(context));
  }

  @override
  Widget build(BuildContext context) {
    globalProvider = Provider.of<GlobalProvider>(context);
    if(globalProvider.rewardPoints == null)
      globalProvider.getRewardPoints();
    return Scaffold(
      body: _buildAppBar(context),
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSuccessMessage('Note',
            'Take a Picture with good quality for better results', true),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
