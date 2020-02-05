import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

  String start_time = "Not set";
  String end_time = "Not set";

  List<User> usersList = [
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
  ScrollController scrollController;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                  child: Text("Setting for Group A", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.add, color: Colors.transparent,),
                              Text("Users", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                              Icon(Icons.add, color: Colors.grey,),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                            itemBuilder: (context, position) {
                              User user = usersList[position];
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.account_circle, size: 35.0, color: Colors.grey,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(user.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 1.0),
                                                child: Text(
                                                  user.isAttend ? 'Attend' : 'Absent',
                                                  style: TextStyle(color: user.isAttend ? Colors.green : Colors.red, fontSize: 13.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                            itemCount: usersList.length,
                          ),
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                                Text("Time Setting", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            height: 130.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text("Start", style: TextStyle(fontSize: 15.0),),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)),
                                      elevation: 4.0,
                                      onPressed: () {
                                        DatePicker.showTimePicker(context,
                                            theme: DatePickerTheme(
                                              containerHeight: 210.0,
                                            ),
                                            showTitleActions: true, onConfirm: (time) {
                                              print('confirm $time');
                                              start_time = '${time.hour} : ${time.minute} : ${time.second}';
                                              setState(() {});
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 18.0,
                                                        color: Colors.teal,
                                                      ),
                                                      Text(
                                                        " $start_time",
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "  Change",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text("end  ", style: TextStyle(fontSize: 15.0),),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)),
                                      elevation: 4.0,
                                      onPressed: () {
                                        DatePicker.showTimePicker(context,
                                            theme: DatePickerTheme(
                                              containerHeight: 210.0,
                                            ),
                                            showTitleActions: true, onConfirm: (time) {
                                              print('confirm $time');
                                              end_time = '${time.hour} : ${time.minute} : ${time.second}';
                                              setState(() {});
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 18.0,
                                                        color: Colors.teal,
                                                      ),
                                                      Text(
                                                        " $end_time",
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text("  Change",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      color: Colors.white,
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
      drawer: Drawer(),
    );
  }
}