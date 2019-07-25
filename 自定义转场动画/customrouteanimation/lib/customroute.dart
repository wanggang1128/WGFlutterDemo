import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder{

  final Widget widget;
  CustomRoute(this.widget) :super(
    transitionDuration:Duration(seconds: 1),
    pageBuilder:(
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
        ){
      return widget;
    },
    transitionsBuilder:(
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
        Widget child
        ){
      //缩放动画
      return ScaleTransition(
          //动画曲线为快出慢进
          scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
          //旋转动画
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
            child: child,
        )
      );
    }
  );
}