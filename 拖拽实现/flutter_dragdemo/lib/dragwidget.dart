import 'package:flutter/material.dart';

class DragWidget extends StatefulWidget {

  final Offset local;
  final Color color;
  DragWidget({Key key, this.local, this.color}):super(key:key);

  @override
  _DragWidgetState createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  
  Offset offset = Offset(0, 0);

  @override
  void initState() {
    super.initState();

    offset = widget.local;
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Draggable(
        data: widget.color,
        child: Container(
          height: 100,
          width: 100,
          color: widget.color,
        ),
        //拖拽时的形状
        feedback: Container(
          height: 110,
          width: 110,
          color: widget.color.withOpacity(0.5),
        ),
        onDraggableCanceled: (Velocity velocity, Offset offset){
          setState(() {
            this.offset = offset;
          });
        },
      )
    );
  }
}
