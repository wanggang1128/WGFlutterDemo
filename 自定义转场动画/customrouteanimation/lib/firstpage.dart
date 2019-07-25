import 'package:flutter/material.dart';

import 'secondpage.dart';
import 'customroute.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一页'),
        elevation: 6.0,
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: MaterialButton(
          onPressed: (){
//            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPage()));
          Navigator.of(context).push(CustomRoute(SecondPage()));
          },
          child: Text('点击进入下一页',style: TextStyle(fontSize: 25, color: Colors.white),),
          color: Colors.red,
        ),
      ),
    );
  }
}
