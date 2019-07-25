import 'package:flutter/material.dart';

import 'bottomview.dart';

class BottomBarWidget extends StatefulWidget {
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  
  List<Widget> dataList;
  int currentIndex = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    dataList = List();
    dataList..add(BottomView('Home'))
    ..add(BottomView('love'))
    ..add(BottomView('launch'))
    ..add(BottomView('dashboard'));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataList[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomView('不规则加号')));
        },
        tooltip: '长按了...',
        child: Icon(Icons.add, color: Colors.white,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: Icon(Icons.home),
              color: Colors.white,
              iconSize: 30,
            ),
            IconButton(
              onPressed: (){
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(Icons.favorite),
              color: Colors.white,
              iconSize: 30,
            ),
            IconButton(
              onPressed: (){
                setState(() {
                  currentIndex = 2;
                });
              },
              icon: Icon(Icons.launch),
              color: Colors.white,
              iconSize: 30,
            ),
            IconButton(
              onPressed: (){
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(Icons.dashboard),
              color: Colors.white,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
