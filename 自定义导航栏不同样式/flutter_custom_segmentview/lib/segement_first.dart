import 'package:flutter/material.dart';

class SegmentFirst extends StatefulWidget {
  @override
  _SegmentFirstState createState() => _SegmentFirstState();
}

class _SegmentFirstState extends State<SegmentFirst> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: '个人订单',
                    ),
                    Tab(
                      text: '专科组订单',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[
                ListTile(title: Text('个人订单01'),),
                ListTile(title: Text('个人订单02'),),
                ListTile(title: Text('个人订单03'),),
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(title: Text('专科组订单01'),),
                ListTile(title: Text('专科组订单02'),),
                ListTile(title: Text('专科组订单03'),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
