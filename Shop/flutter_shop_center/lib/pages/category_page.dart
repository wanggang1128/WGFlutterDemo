import 'package:flutter/material.dart';

import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
          ],
        ),
      ),
    );
  }

}


class LeftCategoryView extends StatefulWidget {
  @override
  _LeftCategoryViewState createState() => _LeftCategoryViewState();
}

class _LeftCategoryViewState extends State<LeftCategoryView> {

  List<Data> list = [];

  @override
  void initState() {
    super.initState();
    _getRequest();
  }

  void _getRequest() async {
    await requestPost('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel listModel = CategoryModel.fromJson(data);
      setState(() {
        list = listModel.data;
      });
    });
  }

  Widget _leftItem(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 20),
        height: ScreenUtil().setHeight(100),
        //decoration之后就不能再用color
        decoration: BoxDecoration(
            color: Colors.white,
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
