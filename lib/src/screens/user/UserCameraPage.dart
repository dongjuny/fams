import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fams/src/screens/Authentication/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

//Future<Widget> cameraMain() async {
//  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
//  final cameras = await availableCameras();
//
//  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
//  final firstCamera = cameras.first;
//
//  return UserCameraPage(
//    // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
//    camera: firstCamera,
//  );
//}

// 사용자가 주어진 카메라를 사용하여 사진을 찍을 수 있는 화면
class UserCameraPage extends StatefulWidget {
//  final CameraDescription camera;
//
//  const UserCameraPage({
//    Key key,
//  }) : super(key: key);

  @override
  UserCameraPageState createState() => UserCameraPageState();
}

class UserCameraPageState extends State {
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
    final firstCamera = cameras.first;
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
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller?.dispose();
    super.dispose();
  }

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
      // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가
      // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future가 완료되면, 프리뷰를 보여줍니다.
//            return CameraPreview(_controller);
            return Stack(
              alignment: FractionalOffset.center,
              children: <Widget>[
//                CameraPreview(_controller),
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
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
                        child: Text(
                          '왼쪽으로 90도 회전 후 촬영해주세요.',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ),
              ],
            );
          } else {
            // 그렇지 않다면, 진행 표시기를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: currentColor,
        child: Icon(Icons.camera_alt),
        // onPressed 콜백을 제공합니다.
        onPressed: () async {
          // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
          // 대응할 수 있습니다.
          try {
            // 카메라 초기화가 완료됐는지 확인합니다.
            await _initializeControllerFuture;

            StorageReference storageReference;
            var path;
            for (int i = 0; i < 30; i++) {
              // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
              path = join(
                // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
                // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
                (await getTemporaryDirectory()).path,
                'jaeyoon${i}.png',
              );

              // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
              await _controller.takePicture(path);
              File _image = File(path);
              storageReference = FirebaseStorage.instance.ref().child(
                  'hustar/jaeyoon/ ${Path.basename(_image.path)}');
              storageReference.putFile(_image);

              print(File(path));
            }

            // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
// 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
            print(e);
          }
        },
      ),
    );
  }
}

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
// 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
// 경로로 Image.file을 생성하세요.
      body: Image.file(File(imagePath)),
    );
  }
}
