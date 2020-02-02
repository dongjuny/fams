import 'package:flutter/material.dart';
import 'package:fams/src/screens/user/UserSignup.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/buttons.dart';
import 'admin/AdminSignUp.dart';
import 'package:page_transition/page_transition.dart';

class ChoicePage extends StatefulWidget {
  final String pageTitle;

  ChoicePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ChoicePage> {
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
                child: Text('Welcome to FAMS!', style: logoStyle),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                child: froyoFlatBtn('관리자', (){
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: AdminSignUP()));
                }),
              ),
              Container(
                margin: EdgeInsets.all(0),
                child: froyoFlatBtn("유저", (){
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: UserSignup()));
                })
              )
            ],
          )),
      backgroundColor: bgColor,
    );
  }
}
