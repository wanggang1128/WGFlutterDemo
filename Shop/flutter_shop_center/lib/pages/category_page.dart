import 'package:flutter/material.dart';

import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
    super.initState();

    _getRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('分类'),
      ),
    );
  }

  void _getRequest(){
    requestPost('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryBigListModel listModel = CategoryBigListModel.fromJson(data['data']);
      listModel.data.forEach((item)=>print(item.mallCategoryName));
//      print('------>'+val);
    });
  }

}
