import 'package:flutter/material.dart';

import 'launchview.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '启动图',
      debugShowCheckedModeBanner: false,
      home: LaunchView(),
    );
  }
}
