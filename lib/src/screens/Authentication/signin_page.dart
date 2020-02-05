import 'package:fams/src/shared/colors.dart';
import 'package:fams/src/shared/styles.dart';
import 'package:flutter/material.dart';
import '../HomePage.dart';
import 'firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



SignInPageState pageState;

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() {
    pageState = SignInPageState();
    return pageState;
  }
}

class SignInPageState extends State<SignInPage> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  bool doRemember = false;

  bool stateVar = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void initState() {
    super.initState();
    getRememberInfo();
  }

  @override
  void dispose() {
    setRememberInfo();
    _mailCon.dispose();
    _pwCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d(fp.getUser());
    if (stateVar == false) {
      return Scaffold(
        key: _scaffoldKey,

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
                  child: RaisedButton(
                    color: Colors.green[300],
                    child: Text(
                      "관리자",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode()); // 키보드 감춤
                      _signInWithGoogle();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: RaisedButton(
                    color: Colors.green[300],
                    child: Text(
                      "유저",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode()); // 키보드 감춤
                      _signInWithGoogle();

                    },
                  ),
                )
              ],
            )),
        backgroundColor: bgColor,
      );
    }else
      return HomePage();
  }

  void _signInWithGoogle() async {
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
    bool result = await fp.signInWithGoogleAccount();
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false)
      showLastFBMessage();
    else
      stateVar = true;
  }

  getRememberInfo() async {
    logger.d(doRemember);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doRemember = (prefs.getBool("doRemember") ?? false);
    });
    if (doRemember) {
      setState(() {
        _mailCon.text = (prefs.getString("userEmail") ?? "");
        _pwCon.text = (prefs.getString("userPasswd") ?? "");
      });
    }
  }

  setRememberInfo() async {
    logger.d(doRemember);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("doRemember", doRemember);
    if (doRemember) {
      prefs.setString("userEmail", _mailCon.text);
      prefs.setString("userPasswd", _pwCon.text);
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