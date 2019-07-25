import 'package:flutter/material.dart';

class BottomView extends StatefulWidget {

  final String _title;
  BottomView(this._title);

  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget._title),),
      body: Center(
        child: Text(widget._title, style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
