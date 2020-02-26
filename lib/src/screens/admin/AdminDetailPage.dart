import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/Authentication/firebase_provider.dart';
import 'package:fams/src/screens/admin/AdminMainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AdminDetailPage extends StatefulWidget {

  Cards groupName;

  AdminDetailPage(this.groupName);

  @override
  _AdminDetailState createState() => new _AdminDetailState(groupName);
}

class User {
  String name;
  bool isAttend;

  User(this.name, this.isAttend);
}

class _AdminDetailState extends State<AdminDetailPage> {

  Cards groupName;

  _AdminDetailState(this.groupName);

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  String startTime = "Not set";
  String endTime = "Not set";

  List<User> usersList = [
  ];

  AnimationController animationController;
  ScrollController scrollController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    String name = groupName.cardTitle;
    String startTime = groupName.startTime;
    String endTime = groupName.endTime;
    return new Scaffold(
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text("ADMIN", style: TextStyle(fontSize: 16.0),),
        backgroundColor: currentColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
        ],
        elevation: 10.0,
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 0.0),
                  child: Text("Info about $name", style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 5.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.transparent,),
                                Text("Users", style: TextStyle(
                                    fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.bold),),
                                Icon(Icons.add, color: Colors.black54,),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance.collection('Group').document(name).collection('User')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (0 == usersList.length) snapshot.data.documents.forEach((doc) => usersList.add(new User('${doc['name']}', true)));
                                if (snapshot.hasError)
                                  return Text("Error: ${snapshot.error}");
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Text("Loading...");
                                  default:
                                    return ListView(
//                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      children: usersList
                                          .map((data) =>
                                          Column(
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(Icons.person),
                                                trailing: Icon(
                                                  Icons.arrow_forward_ios,),
                                                title: Row(
                                                  children: <Widget>[
                                                    Text(data.name, style: TextStyle(fontSize: 15.0,
                                                        fontWeight: FontWeight.bold)),
//                                                    Padding(
//                                                        padding: const EdgeInsets
//                                                            .symmetric(
//                                                            horizontal: 10.0),
//                                                        child: Text(
//                                                          data.isAttend
//                                                              ? "Attend"
//                                                              : "Absent",
//                                                          style: TextStyle(
//                                                              fontSize: 12.0,
//                                                              color: Colors
//                                                                  .grey),)
//                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                            ],
                                          )).toList(),
                                    );
                                }
                              },
                            ),
                            height: 300.0,
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Time", style: TextStyle(
                                    fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                              height: 130.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text("StartTime : ${groupName.startTime}",
                                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text("endTime : $endTime  ",
                                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
//      drawer: Drawer(),
    );
  }
}