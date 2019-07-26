import 'package:flutter/material.dart';

import 'dragwidget.dart';

class DragView extends StatefulWidget {
  @override
  _DragViewState createState() => _DragViewState();
}

class _DragViewState extends State<DragView> {

  Color _color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DragWidget(
            local: Offset(80, 80),
            color: Colors.purple,
          ),
          DragWidget(
            local: Offset(200, 80),
            color: Colors.blueAccent,
          ),
          Center(
            child: DragTarget(
              onAccept: (Color color){
                _color = color;
              },
              builder: (context, listColor, listDynamic) {
                return Container(
                  height: 200,
                  width: 200,
                  color: _color,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
