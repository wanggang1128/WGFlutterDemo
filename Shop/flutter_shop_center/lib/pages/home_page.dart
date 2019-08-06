import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../routers/application.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  //下拉加载属性
  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footKey = new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    var formData = {
      'lon':'115.02932',
      'lat':'35.76189'
    };

    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('百姓生活+'),),
        //FutureBuilder可以异步处理请求
        body: FutureBuilder(
          future: requestPost('homePageContent', formData: formData),
            builder: (context, snapShort){
              if(snapShort.hasData){
                var data = json.decode(snapShort.data.toString());
                //轮播图
                List<Map> swiper;
                if(data['data']['slides'] != null){
                  swiper = (data['data']['slides'] as List).cast();
                }else{
                  swiper = [];
                }

                //网格
                List<Map> topNavigator = (data['data']['category'] as List).cast();

                //广告
                String adPicUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];

                //经理电话组件
                String leaderImageUrl = data['data']['shopInfo']['leaderImage'];
                String leaderPhone = data['data']['shopInfo']['leaderPhone'];

                //推荐商品
                List<Map> recommendList = (data['data']['recommend'] as List).cast();

                //楼层标题
                String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
                //楼层内容
                List<Map> floor1List = (data['data']['floor1'] as List).cast();

                //楼层标题
                String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
                //楼层内容
                List<Map> floor2List = (data['data']['floor2'] as List).cast();

                //楼层标题
                String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
                //楼层内容
                List<Map> floor3List = (data['data']['floor3'] as List).cast();

                return EasyRefresh(
                  refreshFooter: ClassicsFooter(
                    key: _footKey,
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    showMore: true,
                    moreInfoColor: Colors.pink,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadReadyText: '上拉加载...',
                  ),
                  child: ListView(
                    children: <Widget>[
                      SwiperDiy(swiperDataList: swiper,),
                      TopNavigator(navigatorList: topNavigator,),
                      AdBanner(adPicUrl: adPicUrl,),
                      LeaderPhone(leaderImageUrl: leaderImageUrl, leaderPhone: leaderPhone,),
                      Recommend(recommendList: recommendList,),
                      FloorTitle(floorTitle: floor1Title,),
                      FloorContent(floorContent: floor1List,),
                      FloorTitle(floorTitle: floor2Title,),
                      FloorContent(floorContent: floor2List,),
                      FloorTitle(floorTitle: floor3Title,),
                      FloorContent(floorContent: floor3List,),
                      _hotWidget(),
                    ],
                  ),
                  loadMore: () async {
                    var formData = {'page':page};
                    await requestPost('homePageBelowConten',formData: formData).then((val){
                      var data = json.decode(val.toString());
                      List<Map> newGoodsList = (data['data'] as List).cast();
                      setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page ++;
                      });
                    });
                  },
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

  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    alignment: Alignment.center,
    child: Text('火爆商品'),
    color: Colors.transparent,
  );

  Widget _wrapList(){
    if(hotGoodsList.length!=0){

      List<Widget> widgetList = hotGoodsList.map((val){

        return InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            padding: EdgeInsets.all(5.0),
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],width: ScreenUtil().setWidth(370),),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        children: widgetList,
        //一行2列
        spacing: 2,
      );

    }else{
      return Text('');
    }
  }

  //火爆商品组件
  Widget _hotWidget(){
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle,
          _wrapList()
        ],
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
        //禁止滚动
        physics: NeverScrollableScrollPhysics(),
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

//经理电话组件
class LeaderPhone extends StatelessWidget {

  final String leaderImageUrl;
  final String leaderPhone;
  LeaderPhone({this.leaderImageUrl, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _phoneClicked,
        child: Image.network(leaderImageUrl),
      ),
    );
  }

  void _phoneClicked() async {
    String url = 'tel:'+leaderPhone;
//  String url = 'https://www.jianshu.com/u/c9dfc3858121';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw '拨打电话url异常';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {

  //数据源数组
  final List recommendList;
  Recommend({this.recommendList});

  //接下来需要新建三个组件：商品推荐标题、每一个商品item、横向排列item

  //商品推荐标题
  Widget _titleWidget(){
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 5.0, 2.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.5)
        )
      ),
      child: Text('商品推荐',style: TextStyle(color: Colors.pink),),
    );
  }

  //每一个商品item
  Widget _item(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(color: Colors.black12, width: 0.5)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }

  //横向排列item
  Widget _listView(){
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return _item(index);
        },
        itemCount: recommendList.length,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    if (recommendList.length<3){
      //添加一个，为了好看
      recommendList.add(recommendList.last);
    }

    return Container(
      height: ScreenUtil().setHeight(350),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _listView()
        ],
      ),
    );
  }
}

//楼层标题组件
class FloorTitle extends StatelessWidget {

  final String floorTitle;
  FloorTitle({this.floorTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(floorTitle),
    );
  }
}

//楼层内容组件
class FloorContent extends StatelessWidget {

  final List floorContent;
  FloorContent({this.floorContent});

  //商品item
  Widget _floorGoodsItem(goods){
    return Container(
      width: ScreenUtil().setWidth(375.0),
      child: InkWell(
        onTap: (){},
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _floorGoodsItem(floorContent[0]),
        Column(
          children: <Widget>[
            _floorGoodsItem(floorContent[1]),
            _floorGoodsItem(floorContent[2]),
          ],
        )
      ],
    );
  }

  Widget _secondRow(){
    return Row(
      children: <Widget>[
        _floorGoodsItem(floorContent[3]),
        _floorGoodsItem(floorContent[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _secondRow()
        ],
      ),
    );
  }
}


