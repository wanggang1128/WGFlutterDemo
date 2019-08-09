import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val){

        var isLeft = val.isLeft;
        var isRight = val.isRight;

        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              _myTabbar(context, '详情', 'left', isLeft),
              _myTabbar(context, '评论', 'right', isRight),
            ],
          ),
        );
      },
    );
  }


  Widget _myTabbar(BuildContext context, String title, String type, bool isSelected){

    return InkWell(
      onTap: (){

        Provide.value<DetailsInfoProvide>(context).changeDetailsTabbar(type);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: ScreenUtil().setWidth(375),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                color: isSelected?Colors.pink:Colors.black12,
                width: 1
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected?Colors.pink:Colors.black,
            fontSize: isSelected?ScreenUtil().setSp(35):ScreenUtil().setSp(30)
          ),
        ),
      ),
    );
  }
}
