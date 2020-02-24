import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AdminAddPage extends StatefulWidget {
  @override
  _AdminAddState createState() => new _AdminAddState();
}

class User {
  String name;
  bool isAttend;

  User(this.name, this.isAttend);
}

class _AdminAddState extends State<AdminAddPage>{

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  String startTime = "Not set";
  String endTime = "Not set";

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

  List<User> selectedUsers = new List();

  AnimationController animationController;
  ScrollController scrollController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
//    selectedUsers = new List.filled(usersList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text("ADMIN", style: TextStyle(fontSize: 16.0),),
        backgroundColor: currentColor,
        centerTitle: true,
        elevation: 10.0,
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Add Group Setting", style: TextStyle(fontSize: 15.0, color: Colors.black54),),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400)),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 5.0),
                                    labelText: 'Name of the Group',
                                  ),
                                  controller: nameController,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("ID", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400)),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 5.0),
                                    labelText: 'Jetson Nano Mac Id',
                                  ),
                                  controller: idController,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
//                                Icon(Icons.add, color: Colors.transparent,),
                                Text("Add Users", style: TextStyle(fontSize: 15.0, color: Colors.black54),),
//                                Icon(Icons.add, color: Colors.grey,),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                              height: 160.0,
                              child: ListView(
//                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                                children: usersList
                                    .map((data) {
                                  bool saved = selectedUsers.contains(data);
                                  return Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.person),
                                        trailing: Icon(Icons.check, color: saved ? Colors.red : Colors.black54,),
                                        title: Row(
                                          children: <Widget>[
                                            Text(data.name),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            saved ? selectedUsers.remove(data) : selectedUsers.add(data);
                                          });
                                        },
                                      ),
                                      Divider(),
                                    ],
                                  );
                                }).toList(),
                              )
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Time Setting", style: TextStyle(fontSize: 15.0, color: Colors.black54),),
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
                                                startTime = '${time.hour} : ${time.minute} : ${time.second}';
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
                                                          " $startTime",
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
                                                endTime = '${time.hour} : ${time.minute} : ${time.second}';
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
                                                          " $endTime",
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
            RaisedButton(
              child: Text('Add'),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context, nameController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}