import 'package:flutter/material.dart';
import './src/screens/SignInPage.dart';
import './src/screens/HomePage.dart';
import 'src/screens/user/DashboardPage.dart';
import './src/screens/Authentication/a_home.dart';
import './src/screens/admin/AdminMainPage.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'FAMS',
//        home: App()
        home: AdminMainPage()
    );
  }
}