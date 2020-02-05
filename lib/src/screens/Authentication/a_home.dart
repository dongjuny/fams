import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HomePage.dart';
import 'firebase_provider.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            builder: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
        title: "Flutter Firebase",
        home: HomePage(),
      ),
    );
  }
}
