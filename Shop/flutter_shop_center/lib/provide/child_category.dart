import 'package:flutter/material.dart';
import '../model/category.dart';

//点击左侧导航，右侧显示顶部导航

class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];

  //控制右侧导航选中高亮索引
  int childIndex = 0;
  //左侧导航大类id,默认白酒4
  String categoryId = '4';
  //右侧导航标题切换小类id，
  String subId = '';
  //上拉加载更多
  int page = 1;
  //没有更多的提示
  String noMoreText = '';

  //切换左侧大类
  getChildCategoryList(List<BxMallSubDto> list, String cateId){

    //每次改变左侧选项时，右侧导航都恢复到全部这个选项
    childIndex = 0;
    categoryId = cateId;
    page = 1;
    noMoreText = '';


    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    all.comments = 'null';
    all.mallCategoryId = categoryId;
    all.mallSubId = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }

  //改变右侧导航索引
  changeChildIndex(int index, String id){
    childIndex = index;
    subId = id;
    page = 1;
    noMoreText = '';

    notifyListeners();
  }

  addPage(){
    page ++;
    //这里不需要notifyListeners
  }

  //没有更多
  changeNoMoreText(String str){
    noMoreText = str;

    notifyListeners();
  }
}