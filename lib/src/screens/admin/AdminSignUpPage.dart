import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/inputFields.dart';
import '.././SignInPage.dart';
import '../user/DashboardPage.dart';
import 'package:page_transition/page_transition.dart';


class AdminSignUP extends StatefulWidget {
  final String pageTitle;

  AdminSignUP({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<AdminSignUP> {
  @override
  Widget build(BuildContext context) {
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
                // Navigator.of(context).pushReplacementNamed('/signin');
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignInPage()));

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
                      fryoEmailInput('이메일'),
                      Text('가입을 완료하기 위해, 해당 이메일에 본인인증 메일이 발송됩니다.', style: taglineText),
                      fryoPasswordInput('비밀번호'),
                      fryoTextInput('이름'),
                      fryoTextInput('디바이스 이름'),
                    ],
                  ),
                  Positioned(
                    bottom: 15,
                    right: -15,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Dashboard()));
                      },
                      color: primaryColor,
                      padding: EdgeInsets.all(13),
                      shape: CircleBorder(),
                      child: Icon(Icons.arrow_forward, color: white),
                    ),
                  )
                ],
              ),
              height: 360,

              width: double.infinity,
              decoration: authPlateDecoration,
            ),
          ],
        )
    );
  }
}
