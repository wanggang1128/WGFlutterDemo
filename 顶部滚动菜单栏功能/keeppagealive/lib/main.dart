import 'package:flutter/material.dart';

import 'homepage.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '页面切换',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: TopNavigatorBar(),
    );
  }
}

class TopNavigatorBar extends StatefulWidget {
  @override
  _TopNavigatorBarState createState() => _TopNavigatorBarState();
}

class _TopNavigatorBarState extends State<TopNavigatorBar> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面切换，数据不变'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.call),text: '电话',),
            Tab(icon: Icon(Icons.share),text: '分享',),
            Tab(icon: Icon(Icons.chat),text: '聊天',),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomePage(),
          HomePage(),
          HomePage(),
        ],
      ),
    );
  }
}

