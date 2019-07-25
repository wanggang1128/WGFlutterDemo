import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: MaterialButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('点击返回上一页',style: TextStyle(fontSize: 25, color: Colors.white),),
          color: Colors.green,
        ),
      ),
    );
  }
}
