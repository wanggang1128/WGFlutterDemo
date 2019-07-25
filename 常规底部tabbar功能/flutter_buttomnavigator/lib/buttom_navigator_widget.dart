
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/email_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/map_page.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {


  int _currentIndex = 0;
  List<Widget> dataList = List();

  @override
  void initState() {
    // TODO: implement initState

    //..返回调用者自己
    dataList..add(HomePage())
      ..add(EmailPage())
      ..add(MapPage())
      ..add(DashboardPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.redAccent,),
            title: Text('Home',style: TextStyle(color: Colors.redAccent),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.email,color: Colors.redAccent,),
              title: Text('Email',style: TextStyle(color: Colors.redAccent),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map,color: Colors.redAccent,),
              title: Text('Map',style: TextStyle(color: Colors.redAccent),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard,color: Colors.redAccent,),
              title: Text('Dashboard',style: TextStyle(color: Colors.redAccent),),
          ),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        }
      ),
    );
  }
}

