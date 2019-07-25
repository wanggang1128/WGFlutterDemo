import 'package:flutter/material.dart';

import 'firstpage.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '转场动画',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: FirstPage(),
    );
  }
}
