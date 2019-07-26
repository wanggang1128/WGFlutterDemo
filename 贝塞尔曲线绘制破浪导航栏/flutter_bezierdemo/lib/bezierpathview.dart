import 'package:flutter/material.dart';

class BezierPathView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ClipPath(
        clipper: CusBezierPath(),
        child: Container(
          height: 200,
          width: width,
          color: Colors.purple,
        ),
      )
    );
  }
}

class CusBezierPath extends CustomClipper<Path>{
  
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    
    Path bezierPath = Path();
    //规定好四个点，1. 2. 3. 4.
    //1.
    bezierPath.lineTo(0.0, 0.0);
    //2.
    bezierPath.lineTo(0.0, size.height-50.0);

    //绘制第一段贝塞尔曲线
    
    //第一段贝塞尔曲线控制点
    final firstControlPoint = Offset(size.width/4, size.height);
    //第一段贝塞尔曲线结束点
    final firstEndPoint = Offset(size.width/2, size.height-50.0);
    //添加第一段贝塞尔曲线
    //x1, y1, x2, y2分别为控制点的x,y和结束点的x,y
    bezierPath.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy, 
        firstEndPoint.dx, 
        firstEndPoint.dy
    );
    
    //绘制第二段贝塞尔曲线

    //第二段贝塞尔曲线控制点
    final secondControlPoint = Offset(size.width/4*3, size.height-50.0-50.0);
    //第二段贝塞尔曲线结束点
    final secondEndPoint = Offset(size.width, size.height-50.0-20.0);
    //添加第二段贝塞尔曲线
    bezierPath.quadraticBezierTo(
        secondControlPoint.dx, 
        secondControlPoint.dy, 
        secondEndPoint.dx, 
        secondEndPoint.dy
    );
    
    //3.
    bezierPath.lineTo(size.width, size.height-50.0-20.0);
    //4.
    bezierPath.lineTo(size.width, 0.0);
    
    return bezierPath;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
