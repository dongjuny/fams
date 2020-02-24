import 'package:fams/src/screens/user/UserCameraPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomePage.dart';
import 'firebase_provider.dart';
import '../user/UserCameraPage.dart';


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
//        home: HomePage(),
        home: UserCameraPage(),
      ),
    );
  }
}
