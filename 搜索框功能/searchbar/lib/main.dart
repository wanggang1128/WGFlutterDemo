import 'package:flutter/material.dart';

import 'searchbarview.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '搜索栏',
      theme: ThemeData.light(),
      home: SearchBarView(),
    );
  }
}
