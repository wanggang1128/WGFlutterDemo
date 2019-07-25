import 'package:flutter/material.dart';

import 'bottombarwidget.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '底部不规则导航',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: BottomBarWidget(),
    );
  }
}
