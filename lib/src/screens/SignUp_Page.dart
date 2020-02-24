import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/SignUp_Choice_Page.dart';
import 'package:fams/src/screens/user/DashboardPage.dart';
import 'package:fams/src/screens/user/UserCameraPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'SignInPage.dart';
import 'Authentication/firebase_provider.dart';
import 'package:provider/provider.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';

SignedInPageState pageState;

class SignedInPage extends StatefulWidget {
  @override
  SignedInPageState createState() {
    pageState = SignedInPageState(loginAuth);
    return pageState;
  }

  String loginAuth;

  SignedInPage(this.loginAuth);
}

class SignedInPageState extends State<SignedInPage> {
  FirebaseProvider fp;
  TextStyle tsItem = const TextStyle(
      color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.bold);
  TextStyle tsContent = const TextStyle(color: Colors.blueGrey, fontSize: 12);

  String loginAuth;
  SignedInPageState(this.loginAuth);



  TextEditingController newName = TextEditingController();
  TextEditingController newOrganization = TextEditingController();


  double bodysize;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    if (fp.getUser() != null && fp.getUser().isEmailVerified == true && loginAuth != 'Admin' && loginAuth != 'User') {
      return UserMainPage();
    }else {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            title: Text('Sign Up',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignInPages()));

                },
                child: Text('Sign In', style: contrastText),
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
                        Text('FAMS 가입하기', style: h3),
                        fryoTextInput('이름', newName),
                        fryoTextInput('소속', newOrganization),
                      ],
                    ),
                    Positioned(
                      bottom: 15,
                      right: -15,
                      child: FlatButton(
                        onPressed: () {
                          Firestore.instance.collection(loginAuth).document(fp.getUser().uid).setData({
                            'name': newName.text,
                            'organization': newOrganization.text,
                          });

                          if (loginAuth == 'Admin')
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserCameraPage()));
                          else if (loginAuth == 'User')
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserCameraPage()));
                        },
                        color: primaryColor,
                        padding: EdgeInsets.all(13),
                        shape: CircleBorder(),
                        child: Icon(Icons.arrow_forward, color: white),
                      ),
                    )
                  ],
                ),
                height: 230,

                width: double.infinity,
                decoration: authPlateDecoration,
              ),
            ],
          )
      );
    }

  }
}