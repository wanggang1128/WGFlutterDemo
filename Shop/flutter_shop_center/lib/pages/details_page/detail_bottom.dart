import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: <Widget>[
          _getCartWidget(),
          _getAddWidget(),
          _getBuyWidget()
        ],
      ),
    );
  }

  Widget _getCartWidget(){
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(110),
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.center,
        color: Colors.white,
        child: Icon(
          Icons.shopping_cart,
          size: 35,
          color: Colors.pink,
        ),
      ),
    );
  }

  Widget _getAddWidget(){
    return InkWell(
      onTap: (){},
      child: Container(
        color: Colors.green,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.center,
        child: Text(
          '加入购物车',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(35),
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _getBuyWidget(){
    return InkWell(
      onTap: (){},
      child: Container(
        color: Colors.red,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.center,
        child: Text(
          '立即购买',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35),
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
