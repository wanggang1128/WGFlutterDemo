import 'package:flutter/material.dart';
import '../provide/details_info.dart';
import 'package:provide/provide.dart';

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
              Navigator.pop(context);
            }
        ),
      ),
      body: FutureBuilder(
        //异步处理数据
        future: getGoodsInfo(context),
        builder: (context, snapShot){
          if(snapShot.hasData){
            return Container(
              child: Center(
                child: Text('${goodsId}'),
              ),
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