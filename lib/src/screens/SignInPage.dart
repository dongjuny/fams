import 'package:fams/src/screens/user/UserCameraPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';
import 'user/DashboardPage.dart';
import "package:page_transition/page_transition.dart";


class SignInPages extends StatefulWidget {
  final String pageTitle;

  SignInPages({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text('Sign In',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,  child: UserCameraPage()));

            },
            child: Text('Sign Up', style: contrastText),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Welcome to FAMS', style: h3),
                Text('User Login', style: taglineText),
                //fryoTextInput('이메일'),
                fryoPasswordInput('비밀번호'),
                FlatButton(
                  onPressed: () {},
                  child: Text('비밀번호 찾기', style: contrastTextBold),
                )
              ],
            ),
            Positioned(
              bottom: 15,
              right: -15,
              child: FlatButton(
                onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserMainPage()));
                },
                color: primaryColor,
                padding: EdgeInsets.all(13),
               shape: CircleBorder(),
                child: Icon(Icons.arrow_forward, color: white),
              ),
            )
          ],
        ),
        height: 245,

        width: double.infinity,
        decoration: authPlateDecoration,
      ),
        ],
      )
    );
  }
}
