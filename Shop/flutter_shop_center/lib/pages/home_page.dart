import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('网络数据请求'),),
        body: FutureBuilder(
          future: getHomePageContent(),
            builder: (context, snapShort){
              if(snapShort.hasData){
                var data = json.decode(snapShort.data.toString());
                //轮播图
                List<Map> swiper = (data['data']['slides'] as List).cast();
                //网格
                List<Map> topNavigator = (data['data']['category'] as List).cast();
                //广告
                String adPicUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
                return Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiper,),
                    TopNavigator(navigatorList: topNavigator,),
                    AdBanner(adPicUrl: adPicUrl,)
                  ],
                );
              }else{
                return Center(
                  child: Text('加载中......'),
                );
              }
            }
        )
      ),
    );
  }
}

//首页轮播图组件
class SwiperDiy extends StatelessWidget {

  final List swiperDataList;
  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (context, index){
          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill,);
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//网格组件
class TopNavigator extends StatelessWidget {

  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}):super(key:key);

  Widget _gridViewItem(BuildContext context, item){
    return InkWell(
      onTap: (){},
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    //这里只需要10个，为了好看而已
    if(navigatorList.length>10){
      navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(270),
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItem(context, item);
        }).toList(),
      ),
    );
  }
}

//广告组件
class AdBanner extends StatelessWidget {

  final String adPicUrl;
  AdBanner({this.adPicUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicUrl),
    );
  }
}
