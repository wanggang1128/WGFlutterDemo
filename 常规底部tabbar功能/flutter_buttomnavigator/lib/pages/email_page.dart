import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email'),
      ),
      body: Center(
        child: Text('Email', style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
