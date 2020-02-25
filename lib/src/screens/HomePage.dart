import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/admin/AdminAddPage.dart';
import 'package:fams/src/screens/admin/AdminMainPage.dart';
import 'package:fams/src/screens/user/DashboardPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/buttons.dart';
import "package:page_transition/page_transition.dart";

import 'Authentication/firebase_provider.dart';
import 'SignUp_Page.dart';
import 'SignUp_Choice_Page.dart';

class HomePage extends StatefulWidget {
  final String pageTitle;

  HomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseProvider fp;
  final Stream<int> stream =
      Stream.periodic(Duration(seconds: 1), (int x) => x);

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);
  String auth;
  String uid = null;
  bool login = false;
  int loginTime = 0;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);


//    return startPage();
    return StreamBuilder<int>(
        stream: stream, //
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {

          print(loginTime);
          loginTime++;

          if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
            uid = fp.getUser().uid;
          }

          Firestore.instance.collection('User').document(uid).get().then((doc) {
            auth = "${doc['auth']}";
          });

          Firestore.instance.collection('Admin').document(uid).get().then((doc) {
            auth = "${doc['auth']}";
          });

          if (auth == 'User')
            return UserMainPage();
          else if (auth == 'Admin')
            return AdminMainPage();

          if(loginTime > 4)
            return startPage();
          else
            return loadingPage();

        }
    );


  }

  Widget loadingPage(){
    return Scaffold(
      backgroundColor: currentColor,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/logo.png', width: 190, height: 190),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                  ),
                  Container(
                      width: 200,
                      child: Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget startPage(){
    return Scaffold(
      backgroundColor: currentColor,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/logo.png', width: 190, height: 190),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                  ),
                  Container(
                      width: 200,
                      child: Center(
                        child: RaisedButton(
                          child: Text('Start!'),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rotate,
                                    duration: Duration(seconds: 1),
                                    child: SignUpChoicePage()));
                          },
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
