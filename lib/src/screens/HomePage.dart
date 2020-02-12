import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d("user: ${fp.getUser()}");
    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
      return SignedInPage(null);
    } else {
      return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/welcome.png', width: 190, height: 190),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 0),
                  child: Text('FAMS', style: logoStyle),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(bottom: 0),
                  child: froyoFlatBtn('Sign In', (){
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignUpChoicePage()));
                  }),
                ),
                Container(
                  width: 200,
                  padding: EdgeInsets.all(0),
                  child: froyoOutlineBtn('Sign Up', (){
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignUpChoicePage()));
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                )
              ],
            )),
        backgroundColor: bgColor,
      );
      //return SignInPage();
    }
  }
}