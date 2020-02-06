import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'AdminDetailPage.dart';
import 'AdminAddPage.dart';

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainState createState() => new _AdminMainState();
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

class _AdminMainState extends State<AdminMainPage> with TickerProviderStateMixin {

  var appColors = [
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  var currentColor = Color.fromRGBO(99, 138, 223, 1.0);
  var cardIndex = 0;
  ScrollController scrollController;
  List<Cards> cardsList = [
    Cards("Group A", 9, 10),
    Cards("Group B", 100, 1),
    Cards("Group C", 50, 3),
    Cards("Group D", 9, 10),
    Cards("Group E", 100, 1),
    Cards("Group F", 50, 3)
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
      backgroundColor: appColors[cardIndex],
      appBar: new AppBar(
        title: new Text("ADMIN", style: TextStyle(fontSize: 16.0),),
        backgroundColor: appColors[cardIndex],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                      child: Text("Hello, Jane.", style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w400),),
                    ),
                    Text("You have ${cardsList.length} groups.", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w400),),
                    Text("TODAY : JUL 21, 2018", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(),
                    Container(
                      height: 400.0,
                      child: ListView.builder(
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
                              animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
                              curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
                              animationController.addListener(() {
                                setState(() {
                                  currentColor = colorTween.evaluate(curvedAnimation);
                                });
                              });
                              if(details.velocity.pixelsPerSecond.dx > 0) {
                                if(cardIndex > 0) {
                                  cardIndex--;
                                  colorTween = ColorTween(begin:currentColor,end:appColors[cardIndex]);
                                }
                              }else {
                                if(cardIndex < cardsList.length - 1) {
                                  cardIndex++;
                                  colorTween = ColorTween(begin: currentColor,
                                      end: appColors[cardIndex]);
                                }
                              }
                              setState(() {
                                scrollController.animateTo((cardIndex)*324.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                              });
                              colorTween.animate(curvedAnimation);
                              animationController.forward( );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
//                    String newGrooupName = (Navigator.push(context, MaterialPageRoute(builder: (_) => AdminAddPage()))).toString();
//                    cardsList.add(Cards(newGrooupName, 0, 0));
//                    setState(() {
//                      print(cardsList[cardsList.length - 1].cardTitle);
//                    });
                  addNewGroup();
                  },
                  child: Icon(Icons.add, color: Colors.black, size: 35.0,),
                  backgroundColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
  void addNewGroup()async {
    String newGroupName = await Navigator.push(context, MaterialPageRoute(builder: (_) => AdminAddPage()));
//    cardsList.add(Cards(newGroupName, 0, 1));
    setState(() {
//      print(cardsList[cardsList.length - 1].cardTitle);
    });
  }
}