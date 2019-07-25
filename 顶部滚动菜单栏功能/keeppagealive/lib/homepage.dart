import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  int _count = 0;
  
  bool get wantKeepAlive => true;
  
  void _incrementMethod(){
    setState(() {
      _count++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击一次，数量加一',style: Theme.of(context).textTheme.display1,),
            Text('$_count',style: Theme.of(context).textTheme.display3,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementMethod,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
