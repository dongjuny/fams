import 'package:fams/src/screens/SignUp_Choice_Page.dart';
import 'package:fams/src/screens/SignUp_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomePage.dart';
import 'firebase_provider.dart';


class HomeConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            builder: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
        title: "FAMS",
        home: HomePage(),
      ),
    );
  }
}
