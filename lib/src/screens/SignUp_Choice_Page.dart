import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/SignUp_Page.dart';
import 'package:fams/src/shared/colors.dart';
import 'package:fams/src/shared/styles.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Authentication/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SignUpChoicePageState pageState;


class SignUpChoicePage extends StatefulWidget {
  @override
  SignUpChoicePageState createState() {
    pageState = SignUpChoicePageState();
    return pageState;
  }
}

class SignUpChoicePageState extends State<SignUpChoicePage> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  bool doRemember = false;
  bool result = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

  logger.d(fp.getUser());
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Image.asset('images/welcome.png', width: 190),
              Image(image: AssetImage('welcome.png'),),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 0),
                child: Text('Welcome to FAMS!', style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),),
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
                child: RaisedButton(
                  color: Colors.white,
                  child: Text("Admin",),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode()); // 키보드 감춤
                    _signInWithGoogle('Admin');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                child: RaisedButton(
                  color: Colors.white,
                  child: Text("User",),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode()); // 키보드 감춤
                    _signInWithGoogle('User');
                  },
                ),
              )
            ],
          )),
      backgroundColor: currentColor,
    );
  }

  void _signInWithGoogle(String auth) async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-In...")
          ],
        ),
      ));
    result = await fp.signInWithGoogleAccount();
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false)
      showLastFBMessage();
    else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage(auth)));
    }
  }


  showLastFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(fp.getLastFBMessage()),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}