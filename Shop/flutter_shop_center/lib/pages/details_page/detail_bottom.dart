import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/details_info.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Row(
        children: <Widget>[
          _getCartWidget(context),
          _getAddWidget(context),
          _getBuyWidget(context)
        ],
      ),
    );
  }

  Widget _getCartWidget(context){

    return InkWell(
      onTap: (){
      },
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

  Widget _getAddWidget(context){

    var goodsInfo = Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo;

    var goodsID= goodsInfo.goodsId;
    var goodsName =goodsInfo.goodsName;
    var count =1;
    var price =goodsInfo.presentPrice;
    var images= goodsInfo.image1;

    return InkWell(
      onTap: () async {
        await Provide.value<CartProvide>(context).save(goodsID,goodsName,count,price,images);
      },
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

  Widget _getBuyWidget(context){

    var goodsInfo = Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo;

    var goodsID= goodsInfo.goodsId;
    var goodsName =goodsInfo.goodsName;
    var count =1;
    var price =goodsInfo.presentPrice;
    var images= goodsInfo.image1;

    return InkWell(
      onTap: () async {
        await Provide.value<CartProvide>(context).remove();
      },
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
