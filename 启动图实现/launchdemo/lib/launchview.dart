import 'package:flutter/material.dart';

import 'homepage.dart';

class LaunchView extends StatefulWidget {
  @override
  _LaunchViewState createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> with SingleTickerProviderStateMixin {
  
  AnimationController _animationController;
  Animation _animation;
  
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animation.addStatusListener((status){
      //动画完成后，直接跳转到主页
      if(status == AnimationStatus.completed){
        //跳转并结束启动页动画
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context)=>HomePage()),
            (route)=>route == null
        );
      }
    });

    //播放动画
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564134860912&di=b34fa35c3964cddbadced8c21cfe53a2&imgtype=0&src=http%3A%2F%2Fattachments.gfan.com%2Fforum%2F201412%2F27%2F1537483t8k000lky8xo7u7.jpg',
        scale: 2.0,
        fit: BoxFit.cover,
      )
    );
  }
}
