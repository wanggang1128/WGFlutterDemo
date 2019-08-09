import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Provide<DetailsInfoProvide>(
      builder:(context, child, val){
        
        if(val.isLeft){
          var goodsDetail=Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo.goodsDetail;
          return Container(
            child: Html(
                data:goodsDetail
            ),
          );
        }else{
          return Container(
            padding: EdgeInsets.all(10),
            width: ScreenUtil().setWidth(750),
            child: Text(
              '欢迎评论',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(35),
                color: Colors.pink
              ),
            ),
          );
        }
      }
    );
  }
}


