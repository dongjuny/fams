
import 'package:fams/test.dart';
import 'package:flutter/material.dart';
import './src/screens/SignInPage.dart';
import './src/screens/HomePage.dart';
import 'src/screens/SignUp_Choice_Page.dart';
import 'src/screens/user/DashboardPage.dart';
import './src/screens/Authentication/Home_connected.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'FAMS',
        home:HomeConnected()
//      home: HomePage(pageTitle: 'Welcome',)
//        home: AdminDetailPage()
    );
  }
}
