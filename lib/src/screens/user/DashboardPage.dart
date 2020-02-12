
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fams/src/screens/Authentication/firebase_provider.dart';
import 'package:fams/src/screens/admin/AdminAddPage.dart';
import 'package:fams/src/screens/admin/AdminDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserMainPage extends StatefulWidget {

  @override
  _UserMainPageState createState() => new _UserMainPageState();
}

class Cards {
  String cardTitle;
  int attendNum;
  int absentNum;
  int total;

  Cards(this.cardTitle, this.attendNum, this.absentNum) {
    this.total = attendNum + absentNum;
  }
}

class _UserMainPageState extends State<UserMainPage> {


  var appColors = [
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  var cardIndex = 0;

  List<Cards> cardsList = [
    Cards("Group A", 9, 10),
    Cards("Group B", 100, 1),
    Cards("Group C", 50, 3),
    Cards("Group D", 9, 10),
    Cards("Group E", 100, 1),
    Cards("Group F", 50, 3)
  ];

  String u_name = '';
  String u_organization;

  @override
  void initState() {
    super.initState();
  }


  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    Firestore.instance.collection('User').document('uid1').get().then((doc) {
//      print("하아");
      setState(() {
        u_name = "${doc['name']}";
      });
    });

    print("tqtqtqtqtq");
    print(u_name);
    print(u_organization);

    return new Scaffold(
        backgroundColor: appColors[cardIndex],
        appBar: new AppBar(
          title: new Text(fp
              .getUser()
              .uid, style: TextStyle(fontSize: 16.0),),
          backgroundColor: appColors[cardIndex],
          centerTitle: true,
          elevation: 10.0,
        ),
        body: new Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 0.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0.0, 16.0, 0.0, 12.0),
                        child: Text("Hello, $u_name", style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),),
                      ),
                      Text("You have ${cardsList.length} groups.",
                        style: TextStyle(fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),),
                      Text("TODAY : JUL 21, 2018", style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(),
                      Container(
                        height: 400.0,
                        child: ListModule(cardsList: cardsList),
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

class ListModule extends StatefulWidget {

  const ListModule({
    Key key,
    @required this.cardsList,
  }) : super(key: key);

  _ListModuleState createState() => _ListModuleState();
  final List<Cards> cardsList;

//  ListModule(this.cardsList);
}

class _ListModuleState extends State<ListModule> with TickerProviderStateMixin {
  FirebaseProvider fp;

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

    fp = Provider.of<FirebaseProvider>(context);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: cardsList.length,
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => AdminDetailPage(cardsList[position].cardTitle)));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                            child: Text("Attend: ${cardsList[position].attendNum}", style: TextStyle(color: Colors.black54, fontSize: 15.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text("Attend: ${cardsList[position].absentNum}", style: TextStyle(color: Colors.black54, fontSize: 15.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text("${(cardsList[position].attendNum / cardsList[position].total * 100).toStringAsFixed(1)}%", style: TextStyle(fontSize: 28.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(value: cardsList[position].attendNum / cardsList[position].total,),
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
              scrollController.animateTo((cardIndex)*325.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
            });
            animationController.forward( );
          },
        );
      },
    );
  }
}
/*
import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/fryo_icons.dart';
import 'widget/AttendanceStatus.dart';

class Dashboard extends StatefulWidget {
  final String pageTitle;

  Dashboard({Key key, this.pageTitle}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      AttendanceStatus(),
      Text('설정'),
    ];

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            iconSize: 21,
            icon: Icon(Fryo.funnel),
          ),
          backgroundColor: primaryColor,
          title:
          Text('Fams', style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              iconSize: 21,
              icon: Icon(Fryo.magnifier),
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              iconSize: 21,
              icon: Icon(Fryo.alarm),
            )
          ],
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Fryo.shop),
                title: Text(
                  '출석현황',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.cog_1),
                title: Text(
                  '설정',
                  style: tabLinkStyle,
                ))
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[600],
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


 */