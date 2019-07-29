import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

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
                List<Map> swiper = (data['data']['slides'] as List).cast();
                return Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiper,)
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
      height: 300,
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
