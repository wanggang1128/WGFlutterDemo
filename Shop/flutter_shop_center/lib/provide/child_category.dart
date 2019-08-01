import 'package:flutter/material.dart';
import '../model/category.dart';

//点击左侧导航，右侧显示顶部导航

class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];

  getChildCategoryList(List<BxMallSubDto> list){

    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    all.comments = 'null';
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

}