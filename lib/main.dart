import 'package:flutter/material.dart';
import './src/screens/Authentication/Home_connected.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'FAMS',
        home:HomeConnected()
    );
  }
}
