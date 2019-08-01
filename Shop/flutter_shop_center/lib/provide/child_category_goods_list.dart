import 'package:flutter/material.dart';
import '../model/category_goods_model.dart';

//点击左侧导航，右侧显示商品列表

class ChildCategoryGoodsListProvide with ChangeNotifier{

  List<CategoryListData> childCategoryGoodsList = [];

  getChildCategoryGoodsList(List<CategoryListData> list){

    childCategoryGoodsList = list;
    notifyListeners();
  }

}