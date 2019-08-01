import 'package:flutter/material.dart';

import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/category_goods_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/child_category_goods_list.dart';


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
                RightCategoryGoodsListView()
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
    _getCategory();
    getCategoryGoodsListData();
  }

  //左侧导航请求
  void _getCategory() async {
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

  //右侧对应的商品列表请求
  void getCategoryGoodsListData({String categoryId}) async {

    var formDate = {
      'categoryId':categoryId==null?'4':categoryId,
      'categorySubId':"",
      'page':1
    };
    await requestPost('getMallGoods', formData: formDate).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      Provide.value<ChildCategoryGoodsListProvide>(context).getChildCategoryGoodsList(model.data);
    });
  }

  //每一个类别,例如：饮料
  Widget _leftItem(int index){

    //改变点击时的颜色
    bool isClick = false;
    isClick = (index == currentIndex)? true:false;

    return InkWell(
      onTap: (){

        setState(() {
          currentIndex = index;
        });

        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        //给右侧顶部导航提供数据
        Provide.value<ChildCategory>(context).getChildCategoryList(childList);
        //给右侧商品列表提供数据
        getCategoryGoodsListData(categoryId: categoryId);

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

//右侧导航详情
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

//右侧商品列表
class RightCategoryGoodsListView extends StatefulWidget {
  @override
  _RightCategoryGoodsListViewState createState() => _RightCategoryGoodsListViewState();
}

class _RightCategoryGoodsListViewState extends State<RightCategoryGoodsListView> {

  @override
  Widget build(BuildContext context) {

    return Provide<ChildCategoryGoodsListProvide>(
      builder: (context, child, data){
        return Container(
          width: ScreenUtil().setWidth(750.0-180.0),
          height: ScreenUtil().setWidth(1000),
          child: ListView.builder(
            itemCount: data.childCategoryGoodsList.length,
            itemBuilder: (context, index){
              return _goodsItem(data.childCategoryGoodsList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _goodsItem(CategoryListData item){
    return Container(
      padding: EdgeInsets.only(top: 5,bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12,width: 1),
        )
      ),
      child: InkWell(
        onTap: (){},
        child: Row(
          children: <Widget>[
            _itemImage(item),
            Column(
              children: <Widget>[
                _itemRecommend(item),
                _itemPrice(item)
              ],
            ),
          ],
        ),
      ),
    );
  }

  //商品图片组件
  Widget _itemImage(CategoryListData item){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(item.image),
    );
  }

  //商品标题组件
  Widget _itemRecommend(CategoryListData item){
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        item.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(30),),
      ),
    );
  }

  Widget _itemPrice(CategoryListData item){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '￥${item.presentPrice}',
            style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.pink),
          ),
          Text(
            '￥${item.oriPrice}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black12
            ),
          )
        ],
      ),
    );
  }
}
