import 'package:flutter/material.dart';

class SegmentThird extends StatefulWidget {
  @override
  _SegmentThirdState createState() => _SegmentThirdState();
}

class _SegmentThirdState extends State<SegmentThird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("AppBarDemoPage"),
        // backgroundColor: Colors.red,
        centerTitle:true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print('search');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              print('settings');
            },
          )
        ],

      ),
      body: Text('内容'),
    );
  }
}
