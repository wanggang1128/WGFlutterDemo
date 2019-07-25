import 'package:flutter/material.dart';

import 'buttom_navigator_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      title: '底部导航栏切换',
      home: BottomNavigationWidget(),
    );
  }
}
