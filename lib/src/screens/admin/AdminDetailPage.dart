import 'package:flutter/material.dart';

class AdminDetailPage extends StatefulWidget {
  @override
  _AdminDetailState createState() => new _AdminDetailState();
}

class User {
  String name;
  bool isAttend;

  User(this.name, this.isAttend);

}

class _AdminDetailState extends State<AdminDetailPage>{

  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
  var cardIndex = 0;
  ScrollController scrollController;
  List<User> cardsList = [
    User('user A', true),
    User('user B', true),
    User('user C', false),
    User('user D', true),
    User('user E', true),
    User('user F', false),
    User('user G', false),
    User('user H', true),
    User('user I', true),
  ];

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text("ADMIN", style: TextStyle(fontSize: 16.0),),
        backgroundColor: currentColor,
        centerTitle: true,
        actions: <Widget>[
        ],
        elevation: 0.0,
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: Text("Group A", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Container(
                        width: 400.0,
                        height: 200.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}