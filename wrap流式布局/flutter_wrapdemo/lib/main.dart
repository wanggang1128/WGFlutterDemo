import 'package:flutter/material.dart';

import 'wrapview.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '照片选择器',
      theme: ThemeData.light(),
      home: WrapView(),
    );
  }
}
