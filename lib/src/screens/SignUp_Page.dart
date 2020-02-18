import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/SignUp_Choice_Page.dart';
import 'package:fams/src/screens/user/DashboardPage.dart';
import 'package:fams/src/screens/user/UserCameraTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'SignInPage.dart';
import 'Authentication/firebase_provider.dart';
import 'package:provider/provider.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';
import 'admin/AdminMainPage.dart';

SignUpPageState pageState;

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() {
    pageState = SignUpPageState(loginAuth);
    return pageState;
  }

  String loginAuth;

  SignUpPage(this.loginAuth);
}

class SignUpPageState extends State<SignUpPage> {
  FirebaseProvider fp;

  String loginAuth;
  SignUpPageState(this.loginAuth);

//  TextEditingController newName = TextEditingController();
//  TextEditingController newOrganization = TextEditingController();

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  final nameController = TextEditingController();
  final organizationController = TextEditingController();

  double bodysize;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    if (fp.getUser() != null &&
        fp.getUser().isEmailVerified == true &&
        loginAuth != 'Admin' &&
        loginAuth != 'User') {
      return widget;
    } else {
      return Scaffold(
          backgroundColor: currentColor,
          appBar: AppBar(
            elevation: 10.0,
            backgroundColor: currentColor,
            title: Text(
              'FAMS 가입하기',
              style: TextStyle(fontSize: 16.0),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 30.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 350.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 5.0),
                                            hintText: 'Name',
                                            hintStyle:
                                                TextStyle(color: currentColor)),
                                        controller: nameController,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 350.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 5.0),
                                            hintText: 'Organization',
                                            hintStyle:
                                                TextStyle(color: currentColor)),
                                        controller: organizationController,
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    child: Text(
                                      'Add',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: currentColor,
                                    onPressed: () {
                                      Firestore.instance
                                          .collection(loginAuth)
                                          .document(fp.getUser().uid)
                                          .setData({
                                        'name': nameController.text,
                                        'organization':
                                            organizationController.text,
                                        'auth': loginAuth,
                                        'uid': fp.getUser().uid,
                                        'group': []
                                      });
                                      if (loginAuth == 'Admin')
                                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: AdminMainPage()));
                                      else if (loginAuth == 'User')
                                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserMainPage()));
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )

//          ListView(
//            shrinkWrap: true,
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.only(left: 18, right: 18),
//                child: Stack(
//                  children: <Widget>[
//                    Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        fryoTextInput('이름', newName),
//                        fryoTextInput('소속', newOrganization),
//                      ],
//                    ),
//                    Positioned(
//                      bottom: 15,
//                      right: -15,
//                      child: FlatButton(
//                        onPressed: () {
//                          Firestore.instance.collection(loginAuth).document(fp.getUser().uid).setData({
//                            'name': newName.text,
//                            'organization': newOrganization.text,
//                            'auth' : loginAuth,
//                            'uid' : fp.getUser().uid,
//                            'group' : []
//                          });
//
//                          if (loginAuth == 'Admin')
//                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: AdminMainPage()));
//                          else if (loginAuth == 'User')
//                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserMainPage()));
//                        },
//                        color: primaryColor,
//                        padding: EdgeInsets.all(13),
//                        shape: CircleBorder(),
//                        child: Icon(Icons.arrow_forward, color: white),
//                      ),
//                    )
//                  ],
//                ),
//                height: 50,
//
//                width: double.infinity,
//                decoration: authPlateDecoration,
//              ),
//            ],
//          )
          );
    }
  }
}
