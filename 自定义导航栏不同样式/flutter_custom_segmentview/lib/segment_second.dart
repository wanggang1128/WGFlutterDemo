import 'package:flutter/material.dart';

class SegmentSecond extends StatefulWidget {
  @override
  _SegmentSecondState createState() => _SegmentSecondState();
}

class _SegmentSecondState extends State<SegmentSecond> with SingleTickerProviderStateMixin {

  final segmentList = [
    Tab(text: '个人订单',),
    Tab(text: '专科组订单',),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: segmentList.length, vsync: this);
  }

  @override
  void dispose() {

    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二种'),
        centerTitle: true,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          tabs: segmentList,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListTile(title: Text('000000'),),
          ListTile(title: Text('111111'),),
        ],
      ),
    );
  }
}
