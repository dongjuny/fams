import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/Authentication/firebase_provider.dart';
import 'package:fams/src/screens/admin/AdminMainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

_AdminAddState pageState;

class AdminAddPage extends StatefulWidget {
  @override
  _AdminAddState createState() {
    pageState = _AdminAddState(a_organization);
    return pageState;
  }

  String a_organization;

  AdminAddPage(this.a_organization);

}

class User {
  String name;
  bool isAttend;
  String uid;

  User(this.name, this.isAttend, this.uid);
}

class _AdminAddState extends State<AdminAddPage> {
  FirebaseProvider fp;


  String a_organization;
  _AdminAddState(this.a_organization);

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);

  String startTime = "Not set";
  String endTime = "Not set";

  String org = "";

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
    print(a_organization);
  }

  final Stream<int> stream =
  Stream.periodic(Duration(seconds: 1), (int x) => x);

  List<User> usersList = new List();

  @override
  Widget build(BuildContext context) {

    fp = Provider.of<FirebaseProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: currentColor,
      appBar: new AppBar(
//        automaticallyImplyLeading: false,
        title: new Text(
          "ADMIN",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: currentColor,
        centerTitle: true,
        elevation: 10.0,
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Add Group Setting",
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.bold),
                          ),
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
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("Name",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
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
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("ID",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
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
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
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
                                Text(
                                  "Add Users",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.bold),
                                ),
//                                Icon(Icons.add, color: Colors.grey,),
                              ],
                            ),
                          ),

                          Divider(),
                          Container(
                            height: 160.0,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection('User').where('organization', isEqualTo: a_organization)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (0 == usersList.length)
                                  snapshot.data.documents.forEach((doc) => usersList.add(new User('${doc['name']}', true, '${doc['uid']}')));
                                if (snapshot.hasError)
                                  return Text("Error: ${snapshot.error}");
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Text("Loading...");
                                  default:
                                    return
                                      ListView(
                                        children: usersList.map((data) {
                                          bool saved = selectedUsers.contains(data);
                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(Icons.person),
                                                trailing: Icon(
                                                  Icons.check,
                                                  color: saved ? Colors.red : Colors.black54,
                                                ),
                                                title: Row(
                                                  children: <Widget>[
                                                    Text(data.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    saved
                                                        ? selectedUsers.remove(data)
                                                        : selectedUsers.add(data);
                                                  });
                                                },
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ],
                )),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
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
                                Text(
                                  "Time Setting",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                              height: 130.0,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          "Start",
                                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                        elevation: 4.0,
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              theme: DatePickerTheme(
                                                containerHeight: 210.0,
                                              ),
                                              showTitleActions: true,
                                              onConfirm: (time) {
                                                print('confirm $time');
                                                startTime =
                                                '${time.hour} : ${time.minute} : ${time.second}';
                                                setState(() {});
                                              },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50.0,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                              color:
                                                              Colors.teal,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          "end  ",
                                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                        elevation: 4.0,
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              theme: DatePickerTheme(
                                                containerHeight: 210.0,
                                              ),
                                              showTitleActions: true,
                                              onConfirm: (time) {
                                                print('confirm $time');
                                                endTime =
                                                '${time.hour} : ${time.minute} : ${time.second}';
                                                setState(() {});
                                              },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50.0,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                              color:
                                                              Colors.teal,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
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
                                ],
                              ))
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ],
                )),
            RaisedButton(
              child: Text('Add'),

              color: Colors.white,
              onPressed: () {
                print(a_organization);
                Firestore.instance.collection('Group').document(nameController.text).setData({
                  'name' : nameController.text,
                  'endTime': endTime,
                  'organization': a_organization,
                  'startTime' : startTime,
                  'id' : idController.text,
                  'adminUid' : fp.getUser().uid
                });

                Firestore.instance.collection('Admin').document(fp.getUser().uid).updateData({
                  'group' : FieldValue.arrayUnion([nameController.text])
                });


                for (int i=0; i<selectedUsers.length; i++) {
                  Firestore.instance.collection('Group').document(nameController.text).collection('User').document(selectedUsers[i].uid).setData({
                    'name': selectedUsers[i].name,
                    'uid': selectedUsers[i].uid
                  });
                }


                for (int i=0; i<selectedUsers.length; i++) {
                  Firestore.instance.collection('User').where('name', isEqualTo: selectedUsers[i].name).getDocuments().then((QuerySnapshot snap) {
                    snap.documents.forEach((doc) => Firestore.instance.collection('User').document(doc.documentID).updateData( {
                      'group' : FieldValue.arrayUnion([nameController.text])
                    })
                    );
                  });

                  Firestore.instance.collection('Group').document(nameController.text).updateData({
                    'user_list' : FieldValue.arrayUnion([selectedUsers[i].name])
                  });

                }


                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: AdminMainPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
