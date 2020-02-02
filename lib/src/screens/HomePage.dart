import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fams/src/screens/ChoicePage.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/buttons.dart';
import './SignInPage.dart';
import "package:page_transition/page_transition.dart";

class HomePage extends StatefulWidget {
  final String pageTitle;

  HomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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

              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignInPage()));
            }),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.all(0),
            child: froyoOutlineBtn('Sign Up', (){

              Navigator.pushReplacement(context, newRoute);
              // Navigator.of(context).pushReplacementNamed('/signup');
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
  }
}


Future<void> _handleClickMe() async {
  return showCupertinoModalPopup<void>(
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text('Favorite Dessert'),
        message: Text('Please select the best dessert from the options below.'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Profiteroles'),
            onPressed: () { /** */ },
          ),
          CupertinoActionSheetAction(
            child: Text('Cannolis'),
            onPressed: () { /** */ },
          ),
          CupertinoActionSheetAction(
            child: Text('Trifie'),
            onPressed: () { /** */ },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          child: Text('Cancel'),
          onPressed: () { /** */ },
        ),
      );
    },
  );
}