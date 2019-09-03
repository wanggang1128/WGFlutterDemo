import 'package:flutter/material.dart';
import 'package:flutter_custom_segmentview/segement_first.dart';
import 'package:flutter_custom_segmentview/segment_second.dart';
import 'package:flutter_custom_segmentview/segment_third.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: HomePage(),
    );
  }
}



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('第1种'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SegmentFirst()));
            },
          ),
          ListTile(
            title: Text('第2种'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SegmentSecond()));
            },
          ),
          ListTile(
            title: Text('第3种'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SegmentThird()));
            },
          ),
        ],
      ),
    );
  }
}


