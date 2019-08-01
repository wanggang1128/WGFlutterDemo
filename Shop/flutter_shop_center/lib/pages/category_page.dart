import 'package:flutter/material.dart';

import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../provide/child_category.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryView(),
            Column(
              children: <Widget>[
                RightCategoryView(),
              ],
            )
          ],
        ),
      ),
    );
  }

}

//左侧竖向导航栏
class LeftCategoryView extends StatefulWidget {
  @override
  _LeftCategoryViewState createState() => _LeftCategoryViewState();
}

class _LeftCategoryViewState extends State<LeftCategoryView> {

  //数据源数组
  List<Data> list = [];
  //当前选中
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getRequest();
  }

  //数据请求
  void _getRequest() async {
    await requestPost('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel listModel = CategoryModel.fromJson(data);
      setState(() {
        list = listModel.data;
      });
      //解决第一次进入分类界面时，右侧导航没有值
      Provide.value<ChildCategory>(context).getChildCategoryList(list[0].bxMallSubDto);
    });
  }

  //每一个类别,例如：饮料
  Widget _leftItem(int index){

    //改变点击时的颜色
    bool isClick = false;
    isClick = (index == currentIndex)? true:false;

    return InkWell(
      onTap: (){
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategoryList(childList);
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 20),
        height: ScreenUtil().setHeight(100),
        //decoration之后就不能再用color
        decoration: BoxDecoration(
            color:  isClick?Color.fromRGBO(244, 244, 244, 1):Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.black12, width: 1)
            )
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(30)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(color: Colors.black12, width: 1)
          )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return _leftItem(index);
        },
      ),
    );
  }
}

//右侧每个导航详情
class RightCategoryView extends StatefulWidget {
  @override
  _RightCategoryViewState createState() => _RightCategoryViewState();
}

class _RightCategoryViewState extends State<RightCategoryView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(70),
      width: ScreenUtil().setWidth(750.0-180.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12,width: 1))
      ),
      child: Provide<ChildCategory>(
        builder: (context, child, childCategory){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index){
              return _rightTitleItem(childCategory.childCategoryList[index]);
            },
          );
        },
      ),
    );
  }

  Widget _rightTitleItem(BxMallSubDto item){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Text(item.mallSubName, style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }
}
