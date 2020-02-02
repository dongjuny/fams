import 'package:flutter/material.dart';

class AdminMain extends StatefulWidget {
  @override
  _AdminMainState createState() => new _AdminMainState();
}

class Cards {
  String cardTitle;
  int attendNum;
  int absentNum;
  int total;

  Cards(cardTitle, attendNum, absentNum) {
    this.cardTitle = cardTitle;
    this.attendNum = attendNum;
    this.absentNum = absentNum;
    this.total = attendNum + absentNum;
  }

}

class _AdminMainState extends State<AdminMain> with TickerProviderStateMixin {

  var test = "test";
  var appColors = [Color.fromRGBO(231, 129, 109, 1.0),Color.fromRGBO(99, 138, 223, 1.0),Color.fromRGBO(111, 194, 173, 1.0)];
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
  var cardIndex = 0;
  ScrollController scrollController;
  List<Cards> cardsList = [Cards("Group A", 9, 10), Cards("Graoup B", 100, 1),Cards("Group C", 50, 3)];

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
        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(right: 16.0),
//            child: Icon(Icons.search),
//          ),
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Icon(Icons.account_circle, size: 45.0, color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                      child: Text("Hello, Jane.", style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w400),),
                    ),
                    Text("Looks like feel good.", style: TextStyle(color: Colors.white),),
                    Text("You have ${cardsList.length} groups.", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  child: Text("TODAY : JUL 21, 2018", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                ),
                Container(
                  height: 350.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              width: 250.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        //Icon(cardsList[position].icon, color: appColors[position],),
                                        Text("${cardsList[position].cardTitle}", style: TextStyle(fontSize: 28.0),),
                                        Icon(Icons.more_vert, color: Colors.grey,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text("${cardsList.length} Tasks", style: TextStyle(color: Colors.grey),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text("${cardsList[position].cardTitle}", style: TextStyle(fontSize: 28.0),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearProgressIndicator(value: cardsList[position].attendNum / cardsList[position].absentNum,),
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
                            if(cardIndex>0) {
                              cardIndex--;
                              colorTween = ColorTween(begin:currentColor,end:appColors[cardIndex]);
                            }
                          }else {
                            if(cardIndex<2) {
                              cardIndex++;
                              colorTween = ColorTween(begin: currentColor,
                                  end: appColors[cardIndex]);
                            }
                          }
                          setState(() {
                            scrollController.animateTo((cardIndex)*256.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
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
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}