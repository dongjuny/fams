import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fams/src/screens/Authentication/firebase_provider.dart';
import 'package:fams/src/screens/user/DashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;


class UserCameraPage extends StatefulWidget {
  final String userName;
  final String groupName;

  const UserCameraPage(this.userName, this.groupName);

  @override
  UserCameraPageState createState() => UserCameraPageState(userName, groupName);
}

class UserCameraPageState extends State {
  String userName;
  String groupName;

  UserCameraPageState(this.userName, this.groupName);

  CameraController _controller;
  Future _initializeControllerFuture;

  FirebaseProvider fp;

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool check = false;
  int cnt = 0;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Enroll Your Face', style: TextStyle(fontSize: 16.0)),
        backgroundColor: currentColor,
        centerTitle: true,
        elevation: 10.0,
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: FractionalOffset.center,
              children: <Widget>[
                CameraPreview(_controller),
                Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Center(
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1)
                            ),
                            child: Text('사각형 안에 얼굴을 맞춰주세요.', style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          child: check ? Text('${cnt}번째 촬영중이니 움직이지마세요. ', style: TextStyle(color: Colors.white),) : Text('왼쪽으로 90도 회전 후 촬영해주세요.', style: TextStyle(color: Colors.white),),
                        )
                      ],
                    )
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: !check ? FloatingActionButton(
        backgroundColor: currentColor,
        child: Icon(Icons.camera_alt),
        // onPressed 콜백을 제공합니다.
        onPressed: () async {
          setState(() {check = true;});

          try {
            await _initializeControllerFuture;

            StorageReference storageReference;
            var path;
            for (int i = 0; i < 60; i++) {
              setState(() {
                cnt = i;
              });
              path = join(
                (await getTemporaryDirectory()).path,
                '$userName$i.png',
              );

              await _controller.takePicture(path);
              File _image = File(path);
              storageReference = FirebaseStorage.instance.ref().child(
                  '$groupName/$userName/ ${Path.basename(_image.path)}');
              storageReference.putFile(_image);
            }

            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserMainPage()));
          } catch (e) {
            print(e);
          }
        },
      ) : null,

    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}