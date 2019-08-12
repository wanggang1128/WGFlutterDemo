import 'package:flutter/material.dart';
import '../provide/details_info.dart';
import 'package:provide/provide.dart';

import './details_page/details_top_area.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';
import 'details_page/detail_bottom.dart';


class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              //重置DetailsTabBar选中状态
              Provide.value<DetailsInfoProvide>(context).changeDetailsTabbar('left');
              Navigator.pop(context);
            }
        ),
      ),
      body: FutureBuilder(
        //异步处理数据
        future: getGoodsInfo(context),
        builder: (context, snapShot){
          if(snapShot.hasData){
            return Stack(
              children: <Widget>[
                Container(
                    child: ListView(
                      children: <Widget>[
                        DetailTopArea(),
                        DetailsExplain(),
                        DetailsTabBar(),
                        DetailsWeb(),
                      ],
                    )
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  child:DetailBottom(),
                ),
              ],
            );
          }else{
            return Text('暂无数据');
          }
        },
      ),
    );
  }

  Future getGoodsInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '请求完成';
  }
}