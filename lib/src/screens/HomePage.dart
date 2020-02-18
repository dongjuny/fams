import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/admin/AdminMainPage.dart';
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

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d("user: ${fp.getUser()}");
//    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
//      return AdminMainPage();
//    } else {
      return Scaffold(
        backgroundColor: currentColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png', width: 190, height: 190),
//              Container(
//                margin: EdgeInsets.only(bottom: 10, top: 0),
//                child: Text("FAMS", style: TextStyle(
//                    fontSize: 30.0,
//                    color: Colors.white,
//                    fontWeight: FontWeight.w400),),
//              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(0),
                child: RaisedButton(
                  child: Text('Start!'),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignUpChoicePage()));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              )
            ],
          )
        ),
      );
      //return SignInPage();
//    }
  }
}