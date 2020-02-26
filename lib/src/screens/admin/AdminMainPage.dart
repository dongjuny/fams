import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/Authentication/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'AdminDetailPage.dart';
import 'AdminAddPage.dart';

class AdminMainPage extends StatefulWidget {

  @override
  _AdminMainState createState() => new _AdminMainState();
}

class Cards {
  String cardTitle;
  String startTime;
  String endTime;
  String id;
  String organization;

  List<String> user_list;

  int attendNum;
  int absentNum;
  int total;

  Cards(this.cardTitle, this.startTime, this.endTime, this.id, this.organization);
}

class _AdminMainState extends State<AdminMainPage> {

  var appColors = Color.fromRGBO(99, 138, 223, 1.0);
  var cardIndex = 0;


  FirebaseProvider fp;
  final Stream<int> stream = Stream.periodic(Duration(seconds: 1), (int x) => x);

  String a_name = '';
  String a_organization = '';
  var n = new DateTime.now();
  int year = 0;
  int day = 0;
  int month = 0;
  List<String> group_list = new List();
  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }


  List<Cards> cardsList = new List();
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    print(cardsList.length);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColors,
      appBar: new AppBar(
        title: new Text("ADMIN", style: TextStyle(fontSize: 16.0),),
        backgroundColor: appColors,
        centerTitle: true,
        elevation: 10.0,
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<int> (
              stream: stream, //
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                n = new DateTime.now();
                day = n.day;
                month = n.month;
                year = n.year;
                Firestore.instance.collection('Admin').document(fp.getUser().uid).get().then((doc) {
                  a_name = "${doc['name']}";
                  a_organization = "${doc['organization']}";
                });
                Firestore.instance.collection('Group').where('adminUid', isEqualTo: fp.getUser().uid).getDocuments().then((QuerySnapshot snap) {
                  cardsList = new List();
                  snap.documents.forEach((doc) =>
                      cardsList.add(new Cards(
                          "${doc['name']}",
                          "${doc['startTime']}",
                          "${doc['endTime']}",
                          "${doc['id']}",
                          "${doc['organization']}"))
                  );
                });

                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 0.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                            child: Text("Hello, $a_name.", style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),),
                          ),
                          Text("You have ${cardsList.length} groups.",
                            style: TextStyle(fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),),
                          Text("${year}년 ${month}월 ${day}일", style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),),
                          Row(),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(),
                                  Container(
                                    height: 400.0,
                                    child: cardsList.length == 0 ? EmptyCardModule() : ListModule(cardsList: cardsList),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ); // 1초에 한번씩 업데이트 된다.
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: AdminAddPage(a_organization)));
//                    Navigator.push(context, MaterialPageRoute(builder: (_) => AdminAddPage(a_organization)));
                  },
                  child: Icon(Icons.add, color: Colors.black, size: 35.0,),
                  backgroundColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
//      drawer: Drawer(),
    );
  }
}

class ListModule extends StatefulWidget {

  const ListModule({
    Key key,
    @required this.cardsList,
  }) : super(key: key);

  _ListModuleState createState() => _ListModuleState();
  final List<Cards> cardsList;
}

class _ListModuleState extends State<ListModule> with TickerProviderStateMixin {


  List<Cards> cardsList;

  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);
  var cardIndex = 0;
  var itemCount;

  ScrollController scrollController;
  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    cardsList = widget.cardsList;
  }

  Widget build(BuildContext context){

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: cardsList.length,
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, position) {
        String st = cardsList[position].startTime;
        String et = cardsList[position].endTime;
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => AdminDetailPage(cardsList[position])));
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              child: Container(
                width: 300.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${cardsList[position].cardTitle}", style: TextStyle(fontSize: 28.0),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text("StartTime: $st", style: TextStyle(color: Colors.black54, fontSize: 15.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text("EndTime: $et", style: TextStyle(color: Colors.black54, fontSize: 15.0),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
            ),
          ),
          onHorizontalDragEnd: (details) {
            animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
            curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
            if(details.velocity.pixelsPerSecond.dx > 0) {
              if(cardIndex > 0) {
                cardIndex--;
              }
            } else {
              if(cardIndex < cardsList.length - 1) {
                cardIndex++;
              }
            }
            setState(() {
              scrollController.animateTo((cardIndex)*310.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
            });
            animationController.forward( );
          },
        );
      },
    );
  }
}

class EmptyCardModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Card(
          child: Container(
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Please add new group", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          color: Colors.transparent,
        ),
      )
    );
  }

}